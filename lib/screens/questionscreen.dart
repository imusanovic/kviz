import 'package:flutter/material.dart';
import 'package:kviz/models/question.dart';
import 'package:provider/provider.dart';
import 'package:kviz/models/settings.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Future<Question> futurePitanje;

  @override
  void initState() {
    super.initState();
    futurePitanje = fetchPitanje(
        kategorija: Provider.of<Settings>(context, listen: false).getCategory,
        tezina: Provider.of<Settings>(context, listen: false).getDifficulty);
  }

  int tocniOdgovori = 0;
  int brojPitanja = 0;
  List<Color> boje = [Colors.black, Colors.black, Colors.black, Colors.black];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(Icons.settings),
          )
        ],
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
            child: FutureBuilder<Question>(
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
                          const SizedBox(height: 15.0),
                          Text(
                            snapshot.data!.tezina,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
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
                                  itemCount: snapshot.data!.odgovori.length - 1,
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
                                              const Duration(seconds: 2), () {
                                            setState(() {
                                              futurePitanje = fetchPitanje(
                                                  kategorija:
                                                      Provider.of<Settings>(
                                                              context,
                                                              listen: false)
                                                          .getCategory,
                                                  tezina: Provider.of<Settings>(
                                                          context,
                                                          listen: false)
                                                      .getDifficulty);
                                              boje = [
                                                Colors.black,
                                                Colors.black,
                                                Colors.black,
                                                Colors.black
                                              ];
                                            });
                                          });
                                        } else {
                                          setState(() {
                                            boje[index] = Colors.red;
                                            brojPitanja++;
                                          });
                                          await Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            setState(() {
                                              boje[snapshot.data!.odgovori[4]] =
                                                  Colors.green;
                                            });
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 2), () {
                                            setState(() {
                                              futurePitanje = fetchPitanje(
                                                  kategorija:
                                                      Provider.of<Settings>(
                                                              context,
                                                              listen: false)
                                                          .getCategory,
                                                  tezina: Provider.of<Settings>(
                                                          context,
                                                          listen: false)
                                                      .getDifficulty);
                                              boje = [
                                                Colors.black,
                                                Colors.black,
                                                Colors.black,
                                                Colors.black
                                              ];
                                            });
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
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
