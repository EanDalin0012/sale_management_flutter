import 'package:flutter/material.dart';

class IconCheck extends StatelessWidget {
  const IconCheck({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 30,
      child: Image(image: AssetImage('assets/icons/success-green-check-mark.png')),
    );
  }
}
