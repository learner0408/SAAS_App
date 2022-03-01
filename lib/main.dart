import 'package:flutter/material.dart';
import './signIn.dart';
//void main() => runApp(MyApp());

void main() {
  return runApp(MaterialApp(
    title: 'Navigation Basics',
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
