import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: Container(
          width: double.infinity,
          child: Text(
            "SAAS App",
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
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "SAAS",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 5),
                child: TextFormField(
                  controller: _emailInput,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'E-mail',
                      errorText: _emailValidate ? null : "E-mail is Invalid!"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 5),
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
                    padding: EdgeInsets.only(left: 80.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _possibleEmails.contains(_emailInput.text)
                              ? _emailValidate = true
                              : _emailValidate = false;
                          _passwordInput.text == "12345"
                              ? _passwordValidate = true
                              : _passwordValidate = false;
                        });
                        if (_emailValidate == true &&
                            _passwordValidate == true) {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Home()));
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
                onPressed: null,
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
