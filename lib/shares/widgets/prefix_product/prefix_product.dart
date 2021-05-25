import 'package:flutter/material.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';
import 'package:sale_management/shares/statics/default.dart';

class PrefixProduct extends StatelessWidget {
  final String  url;
  const PrefixProduct({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uri = DefaultStatic.url;
    var colorBorder = DarkMode.isDarkMode ? Colors.blueGrey.withOpacity(0.4) :Color(0xFFe4e6eb);
    if(this.url.toString() != 'null') {
      uri = this.url;
    }
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          border: Border.all(color: colorBorder, width: 5),
        ),
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage:NetworkImage(uri),
          backgroundColor: Colors.transparent,
        )
    );
  }
}
