import 'package:flutter/material.dart';
import 'package:kviz/models/question.dart';
import 'package:kviz/models/settings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Question.kategorije = Question.fetchKategorije();
  }

  String? cat;
  String? dif;

  final _settingsKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print('hej:');
    print(Provider.of<Settings>(context, listen: true).getCategory);
    //cat = Provider.of<Settings>(context, listen: true).getCategory;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _settingsKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text('Postavke'),
              ),
              FutureBuilder<List>(
                  future: Question.kategorije,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return DropdownButton<String>(
                          isExpanded: true,
                          value: cat,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              cat = newValue!;
                              Provider.of<Settings>(context, listen: false)
                                  .chooseCategory(cat!);
                            });
                          },
                          items: snapshot.data!
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value['id'].toString(),
                              child: Text(value['name'].toString()),
                            );
                          }).toList(),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              DropdownButton<String>(
                isExpanded: true,
                value: dif,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dif = newValue!;
                  });
                },
                items: <String>['easy', 'medium', 'hard']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value[0].toUpperCase() + value.substring(1)),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
