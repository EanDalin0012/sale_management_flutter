import 'package:flutter/material.dart';

class LoadingProgress extends StatefulWidget {
  const LoadingProgress({Key? key}) : super(key: key);

  @override
  _LoadingProgressState createState() => _LoadingProgressState();
}

class _LoadingProgressState extends State<LoadingProgress> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
