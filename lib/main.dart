import 'package:flutter/material.dart';
import './signIn.dart';
//void main() => runApp(MyApp());

void main() {
  return runApp(MaterialApp(
    title: 'Navigation Basics',
    theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: TextTheme(
            headline6: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
    home: SAAS(),
  ));
}

class SAAS extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
