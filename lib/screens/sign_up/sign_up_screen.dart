import 'package:flutter/material.dart';
import 'package:sale_management/screens/login/login_screen.dart';
import 'package:sale_management/screens/sign_up/widgets/sign_up_body.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          foregroundColor: Colors.purple[900],
          title: Text('signUp.label.signUp'.tr()),
        ),
        body: SignUpBody(),
      ),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogInScreen()),
    );
    return Future<bool>.value(true);
  }
}

