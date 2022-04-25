import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kviz/screens/ui_elements.dart';
import 'package:kviz/services/authentication.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Authentication _auth = Authentication();
  final _registerFormKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context, false, 'Register'),
      body: Container(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _registerFormKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Unesite e-mail.';
                  } else if (!EmailValidator.validate(value)) {
                    return 'E-mail nije u ispravnom obliku';
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
                obscureText: true,
              ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_registerFormKey.currentState!.validate()) {
                    _registerFormKey.currentState!.save();
                    _auth.registerWithEmailAndPassword(email, password);
                    Navigator.pushReplacementNamed(context, '/signin');
                  }
                },
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child: const Text('or Sign In...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
