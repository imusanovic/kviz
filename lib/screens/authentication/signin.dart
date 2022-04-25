import 'package:flutter/material.dart';
import 'package:kviz/screens/ui_elements.dart';
import 'package:kviz/services/authentication.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authentication _auth = Authentication();
  final _loginFormKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context, false, 'Sign in'),
      body: Container(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Unesite korisničko ime.';
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Lozinka',
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Unesite lozinku.';
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_loginFormKey.currentState!.validate()) {
                    _loginFormKey.currentState!.save();
                    _auth.signInWIthEmailAndPassword(email, password);
                  }
                },
                child: Text('Sign In'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text('or Register...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
