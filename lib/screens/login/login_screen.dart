import 'package:flutter/material.dart';
import 'package:sale_management/screens/login/widgets/login_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        title: Text('login.label.login'.tr()
        ),
      ),
      body: SafeArea(
        child: LoginBody(),
      ),
    );
  }
}
