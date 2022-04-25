import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kviz/screens/ui_elements.dart';
import 'package:provider/provider.dart';

class Verify extends StatelessWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loggedInUser = Provider.of<User?>(context);
    return Scaffold(
      appBar: createAppBar(context, false, 'Verification'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Na vašu adresu je poslan link za verifikaciju.'),
            const SizedBox(
              height: 50.0,
            ),
            const Text(
                'Ukoliko niste primili e-mail za verifikaciju kliknite ovdje'),
            const SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
              onPressed: () {
                loggedInUser!.sendEmailVerification();
              },
              child: const Text('Pošalji'),
            ),
          ],
        ),
      ),
    );
  }
}
