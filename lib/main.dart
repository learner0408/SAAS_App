import 'package:flutter/material.dart';

import './screens/signIn.dart';
import './screens/home.dart';
//void main() => runApp(MyApp());

void main() {
  return runApp(MaterialApp(
    title: 'Navigation Basics',
    theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(
            headline6: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: Colors.orange))),
    routes: {Home.routeName: (ctx) => Home()},
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
// StreamProvider<UserLocation>(
//       builder: (context) => LocationService().locationstream,
//       child: SignIn()