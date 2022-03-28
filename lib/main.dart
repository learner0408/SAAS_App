import 'package:flutter/material.dart';
import './screens/create_account.dart';

import './screens/signIn.dart';
import './screens/home.dart';
//void main() => runApp(MyApp());

void main() {
  return runApp(MaterialApp(
    title: 'Navigation Basics',
    theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(
            headline6: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: Colors.orange)),
        appBarTheme: const AppBarTheme(
            titleTextStyle:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
    routes: {
      Home.routeName: (ctx) => Home(),
      CreateAccount.routeName: (ctx) => CreateAccount()
    },
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
