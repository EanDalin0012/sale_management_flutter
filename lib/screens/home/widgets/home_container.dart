import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
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
        FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: () async {
            print('dfa');
            Directory documentsDirectory = await getApplicationDocumentsDirectory();
            ToastUtils.showToast(context: documentsDirectory.path, fToast: fToast);
          },
          child: Text("Test Get Path",style: TextStyle(fontSize: 20.0),),
        ),
      ],
    );
  }


}
