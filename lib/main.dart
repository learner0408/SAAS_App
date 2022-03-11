import 'package:flutter/material.dart';
import 'Widgets/signIn.dart';
//void main() => runApp(MyApp());

void main() {
  return runApp(MaterialApp(
    title: 'Navigation Basics',
    theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: TextTheme(
            headline6: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: Colors.orange))),
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