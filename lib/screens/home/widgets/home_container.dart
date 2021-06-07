import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sale_management/screens/home/widgets/_build_stat_card.dart';
import 'package:sale_management/shares/utils/device_info.dart';
import 'package:sale_management/shares/utils/show_dialog_util.dart';

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
        BuildStatCard(),
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

      ],
    );
  }

  Widget myWidget(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 300,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.amber,
              child: Center(child: Text('$index')),
            );
          }
      ),
    );
  }
}
