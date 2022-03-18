import 'package:flutter/material.dart';
import 'package:kviz/models/pitanje.dart';

void main() {
  runApp(const MaterialApp(home: Kviz()));
}

class Kviz extends StatefulWidget {
  const Kviz({Key? key}) : super(key: key);

  @override
  State<Kviz> createState() => _KvizState();
}

class _KvizState extends State<Kviz> {
  late Future<Pitanje> futurePitanje;

  @override
  void initState() {
    super.initState();
    futurePitanje = fetchPitanje();
  }

  int tocniOdgovori = 0;
  int brojPitanja = 0;
  List<Color> boje = [Colors.black, Colors.black, Colors.black, Colors.black];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kviz'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Text(
            '$tocniOdgovori / $brojPitanja',
            style: const TextStyle(
              fontSize: 25.0,
            ),
          ),
          Expanded(
            child: FutureBuilder<Pitanje>(
              future: futurePitanje,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data!.kategorija,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Text(
                            snapshot.data!.pitanje,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                          const SizedBox(height: 50.0),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: ListView.builder(
                                  itemCount: snapshot.data!.odgovori.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TextButton(
                                      onPressed: (() async {
                                        if (snapshot.data!.odgovori[index] ==
                                            snapshot.data!.tocan) {
                                          setState(() {
                                            boje[index] = Colors.green;
                                            tocniOdgovori++;
                                            brojPitanja++;
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 2),
                                              () {});
                                          setState(() {
                                            futurePitanje = fetchPitanje();
                                            boje = [
                                              Colors.black,
                                              Colors.black,
                                              Colors.black,
                                              Colors.black
                                            ];
                                          });
                                        } else {
                                          setState(() {
                                            boje[index] = Colors.red;
                                            brojPitanja++;
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 2),
                                              () {});
                                          setState(() {
                                            futurePitanje = fetchPitanje();
                                            boje = [
                                              Colors.black,
                                              Colors.black,
                                              Colors.black,
                                              Colors.black
                                            ];
                                          });
                                        }
                                      }),
                                      child: Text(
                                        '${index + 1}. ${snapshot.data!.odgovori[index]}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: boje[index],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
