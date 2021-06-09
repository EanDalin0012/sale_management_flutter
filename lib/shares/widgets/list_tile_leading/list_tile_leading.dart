import 'package:flutter/material.dart';

class ListTileLeadingWidget extends StatelessWidget {
  final String netWorkURL;

  const ListTileLeadingWidget({Key? key, required this.netWorkURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(netWorkURL),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
