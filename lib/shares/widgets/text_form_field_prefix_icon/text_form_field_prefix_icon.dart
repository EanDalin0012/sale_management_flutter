import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';
import 'package:sale_management/shares/statics/default.dart';

class TextFormFieldPrefixIcon extends StatelessWidget {
  final String  url;
  const TextFormFieldPrefixIcon({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorBorder = DarkMode.isDarkMode ? Colors.blueGrey.withOpacity(0.4) :Color(0xFFe4e6eb);
    return Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: colorBorder, width: 4),
        ),
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage:NetworkImage(this.url),
          backgroundColor: Colors.transparent,
        )
    );
  }
}
