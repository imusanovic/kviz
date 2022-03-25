import 'package:flutter/material.dart';
import 'package:kviz/screens/questionscreen.dart';
import 'package:kviz/screens/settingsscreen.dart';
import 'package:provider/provider.dart';
import 'package:kviz/models/settings.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Settings(),
      child: MaterialApp(
        routes: {
          '/': (context) => const QuestionScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
        initialRoute: '/',
      ),
    ),
  );
}
