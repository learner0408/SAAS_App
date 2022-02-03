import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  //const SignIn({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            child: Text(
              "SAAS App",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Column(
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
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 5),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 5),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: null,
                  child: Text("Need Help?"),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 80.0),
                  child: ElevatedButton(
                    onPressed: () => print("It's working!"),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: null,
              child: Text("Create an account"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
