import 'package:flutter/material.dart';
import 'package:kviz/models/question.dart';
import 'package:kviz/screens/ui_elements.dart';
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

  Map<String, Color> tezinaColors = {
    'hard': Colors.red[200]!,
    'medium': Colors.yellow[200]!,
    'easy': Colors.green[200]!,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context, true, 'Kviz'),
      body: FutureBuilder<Question>(
        future: futurePitanje,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return AnimatedContainer(
                duration: const Duration(seconds: 1),
                color: tezinaColors[snapshot.data!.tezina],
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        '$tocniOdgovori / $brojPitanja',
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        snapshot.data!.kategorija,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Text(
                        snapshot.data!.pitanje,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeLeft: true,
                          removeRight: true,
                          child: ListView.builder(
                              itemCount: snapshot.data!.odgovori.length - 1,
                              itemBuilder: (BuildContext context, int index) {
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
                                              kategorija: Provider.of<Settings>(
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
                                              kategorija: Provider.of<Settings>(
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
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
