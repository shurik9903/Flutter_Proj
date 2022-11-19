import 'dart:math';

import 'package:flutter/material.dart';

import '../modules/RegistrationFetch.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email = "";
  String login = "";
  String password = "";
  String password2 = "";
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 300),
            child: Column(
              children: [
                Wrap(
                  runSpacing: 10,
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          login = value;
                        });
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Логин'),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Почта'),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Пароль'),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          password2 = value;
                        });
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Повторить пароль'),
                    ),
                    Text(msg),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text("Назад"),
                    ),
                    TextButton(
                      onPressed: () async {
                        registrationFetch(login, email, password, password2)
                            .then((value) {
                          setState(() {
                            msg = value;
                          });
                        }).catchError((error) {
                          msg = error.toString();
                        });
                      },
                      child: const Text("Регистрация"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
