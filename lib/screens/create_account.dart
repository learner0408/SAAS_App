import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  //const CreateAccount({ Key? key }) : super(key: key);
  static const routeName = '/create-account';

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController confirmPassword = TextEditingController();

bool _emailValidate = true;
bool _passswordValidate = true;

Widget AccountTextField(String title, TextEditingController controller,
    String errormsg, bool validate, TextInputType inputType) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 15,
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: title,
          fillColor: Colors.white70,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7))),
          errorText: validate ? null : errormsg),
      keyboardType: inputType,
    ),
  );
}

//void _addAccount() {}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    Map<String, Object> result =
        (ModalRoute.of(context)?.settings.arguments) as Map<String, Object>;
    List<String> emails = result['emails'] as List<String>;
    Map<String, String> passwords = result['passwords'] as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new account!"),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 8, left: 15, right: 15),
            child: Text(
              "Join us!",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AccountTextField(
              "E-mail id",
              email,
              "Email is either empty or already exists",
              _emailValidate,
              TextInputType.emailAddress),
          const SizedBox(
            height: 15,
          ),
          AccountTextField("Password", password, "Password is not valid",
              _passswordValidate, TextInputType.number),
          const SizedBox(
            height: 15,
          ),
          AccountTextField(
              "Confirm Password",
              confirmPassword,
              "Password is not valid",
              _passswordValidate,
              TextInputType.number),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                if (email.text != '' &&
                    password.text != '' &&
                    confirmPassword.text != '') {
                  if (emails.contains(email.text) == false &&
                      (email.text.endsWith('@gmail.com') ||
                          email.text.endsWith('@iitrpr.ac.in')) &&
                      password.text == confirmPassword.text) {
                    _emailValidate = true;
                    _passswordValidate = true;
                    emails.add(email.text);
                    passwords[email.text] = password.text;
                    Navigator.of(context).pop();
                  }
                  setState(() {
                    _emailValidate = false;
                    _passswordValidate = false;
                  });
                }
              },
              child: const Text("Let's goo!"))
        ]),
      ),
    );
  }
}
