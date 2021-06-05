import 'package:flutter/material.dart';

class InfiniteScrollLoading extends StatelessWidget {
  const InfiniteScrollLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
              )
          ),
          Text('Loading'),
          SizedBox(
            height: 5,
          )
        ]
    );
  }
}
