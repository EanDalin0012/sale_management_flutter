import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconCheck extends StatelessWidget {
  const IconCheck({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Color(0xff273965),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white, width: 3),
      ),
      // child: Image(
      //     image: AssetImage('assets/icons/success-green-check-mark.png')
      // ),
      child: Center(child: FaIcon(FontAwesomeIcons.check, size: 20, color: Colors.white)),
    );
  }
}
