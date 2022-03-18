import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:html_unescape/html_unescape.dart';

class Pitanje {
  String kategorija;
  String pitanje;
  String tezina;
  String tocan;
  List<dynamic> netocni;
  List<dynamic> odgovori = [];

  Pitanje(
      {required this.kategorija,
      required this.pitanje,
      required this.tezina,
      required this.tocan,
      required this.netocni}) {
    int r = Random().nextInt(4);
    int c = 0;
    for (int i = 0; i < 4; i++) {
      if (r == i) {
        odgovori.add(tocan);
      } else {
        odgovori.add(netocni[c]);
        c++;
      }
    }
  }

  factory Pitanje.fromJson(Map<String, dynamic> json) {
    HtmlUnescape unescape = HtmlUnescape();
    return Pitanje(
      kategorija: unescape.convert(json['results'][0]['category']),
      pitanje: unescape.convert(json['results'][0]['question']),
      tezina: unescape.convert(json['results'][0]['difficulty']),
      tocan: unescape.convert(json['results'][0]['correct_answer']),
      netocni: (json['results'][0]['incorrect_answers']),
    );
  }
}

Future<Pitanje> fetchPitanje() async {
  final response = await http
      .get(Uri.parse('https://opentdb.com/api.php?amount=1&type=multiple'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Pitanje.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
