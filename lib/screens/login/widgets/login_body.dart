import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/sign_up/sign_up_screen.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/constants/text_style.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
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

  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;
  var focusedBorder;


  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    this.style = InputDecorationUtils.textFormFieldStyle();
    this.labelStyle = InputDecorationUtils.inputDecorationLabelStyle();
    this.hintStyle = InputDecorationUtils.inputDecorationHintStyle();
    this.enabledBorder = InputDecorationUtils.enabledBorder();
    this.focusedBorder = InputDecorationUtils.focusedBorder();

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
                  _buildAddButton(),
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
      style: this.style,
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
        labelStyle: this.labelStyle,
        hintText: 'login.holder.enterYourEmail'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(
              svgPaddingLeft: 15,
              svgIcon: "assets/icons/mail_black_24dp.svg"
          )
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      style: this.style,
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: 'login.label.password'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'login.holder.enterYourPassword'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        focusedBorder: this.focusedBorder,
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

  Widget _buildAddButton() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - getProportionateScreenWidth(20),
      // margin: EdgeInsets.only(right: 10),
      child: RaisedButton(
        color: Color(0xff273965),
        textColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Stack(
          children: <Widget>[
            Center(child: Text('login.label.continue'.tr(), style: TextStyle(
                fontFamily: fontDefault,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white),)
            ),
            Positioned(
                right: 0,
                top: 12.5,
                child: FaIcon(FontAwesomeIcons.signOutAlt, size: 25, color: Colors.white)
            ),
          ],
        ),
        onPressed: () {
          KeyboardUtil.hideKeyboard(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(selectIndex: 0)),
          );
        },
      ),
    );
  }

  void onTabToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }
}
