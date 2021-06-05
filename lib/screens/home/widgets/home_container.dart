import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sale_management/screens/home/widgets/_build_stat_card.dart';
import 'package:sale_management/screens/test/infinite_scroll_pagination/infinite_scroll_pagination_screen.dart';
import 'package:sale_management/shares/utils/device_info.dart';
import 'package:sale_management/shares/utils/show_dialog_util.dart';
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
        RaisedButton.icon(
          onPressed: (){
            DeviceInfoUtils.initPlatformState().then((value) {
              ToastUtils.showToast(context: value['model'] + '%'+ value['product']+'###'+ value.toString(), fToast: fToast);
            });
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          label: Text('Button With Left Icon',
            style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.android, color:Colors.white,),
          textColor: Colors.white,
          splashColor: Colors.red,
          color: Colors.green
        ),

        RaisedButton.icon(
            onPressed: (){
              DeviceInfoUtils.initPlatformState().then((value) {
                ShowDialogUtil.dialog(
                    title: Text('Alert'),
                    buildContext: context,
                    content: Text(value.toString())
                );
              });
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text('Alert',
              style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.android, color:Colors.white,),
            textColor: Colors.white,
            splashColor: Colors.red,
            color: Colors.green
        ),

        RaisedButton.icon(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CharacterListViewScreen()),
              );
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text('CharacterListViewScreen',
              style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.android, color:Colors.white,),
            textColor: Colors.white,
            splashColor: Colors.red,
            color: Colors.green
        ),

        BuildStatCard()
      ],
    );
  }
}
