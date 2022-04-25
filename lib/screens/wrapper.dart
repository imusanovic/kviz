import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kviz/screens/authentication/signin.dart';
import 'package:kviz/screens/authentication/verify.dart';
import 'package:kviz/screens/questionscreen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    var loggedInUser = Provider.of<User?>(context);
    print(loggedInUser);
    if (loggedInUser == null) {
      return const SignIn();
    } else if (loggedInUser.emailVerified == false) {
      return const Verify();
    } else {
      return const QuestionScreen();
    }
  }
}
