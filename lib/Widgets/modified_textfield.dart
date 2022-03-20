import 'package:flutter/material.dart';

class ModifiedTxtField extends StatelessWidget {
  //const DestinationInput({Key? key}) : super(key: key);
  TextEditingController controller;
  String label;
  String hint;
  Icon prefixIcon;
  Function locationCallback;
  ModifiedTxtField(this.controller, this.label, this.hint, this.prefixIcon,
      this.locationCallback);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * 0.9,
          alignment: Alignment.center,
          child: TextField(
            onChanged: (value) {
              locationCallback(value);
            },
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: prefixIcon,
                labelText: label,
                hintText: hint,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
          ),
        );
      },
    );
  }
}
