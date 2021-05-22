import 'package:flutter/material.dart';

class CircularProgressLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
