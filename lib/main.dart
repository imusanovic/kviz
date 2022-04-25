import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kviz/screens/authentication/register.dart';
import 'package:kviz/screens/authentication/signin.dart';
import 'package:kviz/screens/questionscreen.dart';
import 'package:kviz/screens/settingsscreen.dart';
import 'package:kviz/screens/wrapper.dart';
import 'package:kviz/services/authentication.dart';
import 'package:provider/provider.dart';
import 'package:kviz/models/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Settings(),
        ),
        StreamProvider<User?>.value(
          value: Authentication().user,
          catchError: (_, __) => null,
          initialData: null,
        )
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => const Wrapper(),
          '/question': (context) => const QuestionScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/signin': (context) => const SignIn(),
          '/register': ((context) => const Register())
        },
        initialRoute: '/',
      ),
    ),
  );
}
