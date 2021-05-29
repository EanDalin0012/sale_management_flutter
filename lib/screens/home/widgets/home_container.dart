import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sale_management/screens/home/widgets/_build_stat_card.dart';
import 'package:sale_management/shares/utils/toast_util.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key ? key}) : super(key: key);

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    print('dd');
    return Column(
      children: <Widget>[
        BuildStatCard()
      ],
    );
  }
}
