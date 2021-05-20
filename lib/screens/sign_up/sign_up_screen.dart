import 'package:flutter/material.dart';
import 'package:sale_management/screens/sign_up/widgets/sign_up_body.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text('signUp.label.signUp'.tr()),
      ),
      body: SignUpBody(),
    );
  }
}
