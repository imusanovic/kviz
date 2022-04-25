import 'package:flutter/material.dart';
import 'package:kviz/services/authentication.dart';

AppBar createAppBar(BuildContext context, bool buttons, String naslov) {
  Authentication _auth = Authentication();
  return AppBar(
    actions: buttons
        ? [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () async {
                await _auth.signOut();
                //Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.logout),
            )
          ]
        : [],
    title: Text(naslov),
    centerTitle: true,
  );
}
