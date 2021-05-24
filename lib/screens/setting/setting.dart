import 'package:flutter/material.dart';
import 'package:sale_management/screens/setting/widgets/setting_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        title: Text('setting.label.setting'.tr()),
      ),
      body: SafeArea(
        child: SettingBody(
          onChanged: (value) {
            setState(() {
              DarkMode.isDarkMode = value;
            });
          },
        ),
      ),
    );
  }
}
