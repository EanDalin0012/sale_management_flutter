import 'package:flutter/material.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key ? key}) : super(key: key);

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {
    print('dd');
    return Container(
      child: Text('Home Container'),
    );
  }
}
