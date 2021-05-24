import 'package:flutter/material.dart';

class PrefixProduct extends StatelessWidget {
  final String url;
  const PrefixProduct({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 36,
        height: 36,
        padding: const EdgeInsets.all(7.0),
        child: CircleAvatar(
          radius: 30.0,
          backgroundImage:NetworkImage(this.url),
          backgroundColor: Colors.transparent,
        )
    );
  }
}
