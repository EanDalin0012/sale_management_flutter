import 'package:flutter/material.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';
import 'package:sale_management/shares/statics/default.dart';

class PrefixPerson extends StatelessWidget {
  final String url;

  const PrefixPerson({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorBorder = DarkMode.isDarkMode
        ? Colors.blueGrey.withOpacity(0.4)
        : Color(0xFFe4e6eb);
    String uri = DefaultStatic.personUrl;
    if (this.url.toString() != 'null') {
      uri = this.url;
    }
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          border: Border.all(color: colorBorder, width: 5),
        ),
        // padding: const EdgeInsets.all(7.0),
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(uri),
          backgroundColor: Colors.transparent,
        )
    );
  }
}
