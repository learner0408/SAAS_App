import 'package:flutter/material.dart';

Future PolylineDialog(ctx, distance, duration) {
  return showDialog(
      context: ctx,
      builder: (context) {
        return Dialog(
          child: Container(
              height: 70,
              width: 40,
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Text("Distance: ${distance}"),
                SizedBox(height: 10),
                Text("Duration: ${duration}")
              ])),
        );
      });
}
