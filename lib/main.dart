import 'package:flutter/material.dart';
import './signIn.dart';

void main() {
  return runApp(SAAS());
}

class SAAS extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
