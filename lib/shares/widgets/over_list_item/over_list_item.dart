import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/constants/text_style.dart';

class OverListItem extends StatelessWidget {
  final String text;
  final int length;
  const OverListItem({Key? key, required this.text, required this.length}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffd9dbdb).withOpacity(0.4),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: 20,
          top: 10,
          right: 20,
          bottom: 10
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text.toString(),
            style: containStyle,
          ),
          Text(this.length.toString(), style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontDefault),)
        ],
      ),
    );
  }
}
