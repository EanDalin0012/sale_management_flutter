import 'package:flutter/material.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/sign_up/sign_up_screen.dart';
import 'package:sale_management/shares/constants/text_style.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/shares/widgets/default_button/default_button.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginBody extends StatefulWidget {
  LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.screenHeight * 0.07),
                  buildEmailFormField(),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  buildPasswordFormField(),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Checkbox(
                        value: remember,
                        onChanged: (value) {
                          setState(() {
                            remember = value!;
                          });
                        },
                      ),
                      Text('login.label.rememberMe'.tr()),
                      Spacer(),
                      GestureDetector(
                        onTap: () => onTapForgotPassword(),
                        child: Text(
                          'login.label.forgotPassword'.tr(),
                          style: TextStyle(decoration: TextDecoration
                              .underline),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  DefaultButton(
                    text: 'login.label.continue'.tr(),
                    press: () {
                      // if (_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();
                      //   // if all are valid then go to success screen
                      //
                      // }
                      KeyboardUtil.hideKeyboard(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(selectIndex: 0)),
                      );
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  noAccount()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapForgotPassword() {}

  TextFormField buildEmailFormField() {
    return TextFormField(
      style: InputDecorationUtils.textFormFieldStyle(),
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        return null;
      },
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: 'login.label.email'.tr(),
        hintText: 'login.holder.enterYourEmail'.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      style: InputDecorationUtils.textFormFieldStyle(),
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: 'login.label.password'.tr(),
        hintText: 'login.holder.enterYourPassword'.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
            svgIcon: "assets/icons/Lock.svg"
        ),
      ),
    );
  }

  Row noAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'login.label.dontHaveAnAccount'.tr(),
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => onTabToSignUp(context),
          child: Text(
            'login.label.signUp'.tr(),
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }

  void onTabToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }
}
