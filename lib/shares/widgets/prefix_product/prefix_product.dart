import 'package:flutter/material.dart';
import 'package:sale_management/shares/statics/default.dart';

class PrefixProduct extends StatelessWidget {
  final String  url;
  const PrefixProduct({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uri = DefaultStatic.url;
    if(this.url.toString() != 'null') {
      uri = this.url;
    }
    return Container(
        width: 36,
        height: 36,
        padding: const EdgeInsets.all(7.0),
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage:NetworkImage(uri),
          backgroundColor: Colors.transparent,
        )
    );
  }
}
