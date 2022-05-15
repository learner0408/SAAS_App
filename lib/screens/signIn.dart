import 'package:flutter/material.dart';
import './create_account.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();
  bool _emailValidate = false;
  bool _passwordValidate = false;
  final _possibleEmails = [
    "2019eeb1144@iitrpr.ac.in",
    "2019eeb1148@iitrpr.ac.in",
    "2019eeb1197@iitrpr.ac.in",
    "sam@iitrpr.ac.in"
  ];
  final Map<String, String> _possiblePasswords = {
    "2019eeb1144@iitrpr.ac.in": "12345",
    "2019eeb1148@iitrpr.ac.in": "12345",
    "2019eeb1197@iitrpr.ac.in": "12345",
    "sam@iitrpr.ac.in": "12345",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        title: Container(
          width: double.infinity,
          child: const Text(
            "Network Assisted Navigation System",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "NANS",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 15, bottom: 5),
                child: TextFormField(
                  controller: _emailInput,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'E-mail',
                      errorText: _emailValidate ? null : "E-mail is Invalid!"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                child: TextFormField(
                  controller: _passwordInput,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      errorText:
                          _passwordValidate ? null : "Password is Invalid!"),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: null,
                    child: Text(
                      "Need Help?",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _possibleEmails.contains(_emailInput.text)
                              ? _emailValidate = true
                              : _emailValidate = false;
                          if (_emailValidate) {
                            _passwordInput.text ==
                                    _possiblePasswords[_emailInput.text]
                                ? _passwordValidate = true
                                : _passwordValidate = false;
                          }
                        });
                        if (_emailValidate == true &&
                            _passwordValidate == true) {
                          Navigator.of(context).pushNamed(Home.routeName);
                        }
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(CreateAccount.routeName, arguments: {
                  "emails": _possibleEmails,
                  "passwords": _possiblePasswords
                }),
                child: Text(
                  "Create an account",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
