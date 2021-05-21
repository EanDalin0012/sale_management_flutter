import 'package:flutter/material.dart';
import 'package:sale_management/screens/setting/widgets/setting_body.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text('setting.label.setting'.tr()),
      ),
      body: SafeArea(
        child: SettingBody(),
      ),
    );
  }
}
