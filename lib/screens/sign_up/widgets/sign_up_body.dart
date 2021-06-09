import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/reg_exp.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/shares/widgets/gender_option/gender_optional.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {

  var emailController = new TextEditingController();
  var firstNameController = new TextEditingController();
  var lastNameController = new TextEditingController();
  var passwordController = new TextEditingController();
  var confPasswordController = new TextEditingController();
  var gender;
  late String email;
  late String password;
  bool remember = false;
  bool isClickSave = false;
  final _formKey = GlobalKey<FormState>();
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    SizeConfig.init(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _body(),
          InkWell(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                save();
              },
              child: WidgetsUtil.overlayKeyBardContainer(
                  text: 'common.label.save'.tr())
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.03), // 4%
                    Text('signUp.label.createAccount'.tr(),
                        style: TextStyleUtils.headingStyle()),
                    Text(
                      'signUp.label.completeDetails'.tr(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              _buildFirstNameField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildLastNameField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              GenderForm(
                  size: size,
                  autovalidate: false,
                  initialValue: this.gender,
                  onChanged: (value) {
                    checkFormValid();
                    setState(() {
                      this.gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select gender!';
                    }
                    return null;
                  }
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              buildEmailFormField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildPasswordField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildConfPasswordField(),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildConfPasswordField() {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.next,
      controller: confPasswordController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'signUp.message.pleaseEnterConfirmPassword'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'signUp.label.confirmPassword'.tr(),
        hintText: 'signUp.holder.enterConfirmPassword'.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.next,
      controller: passwordController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'signUp.message.pleaseEnterPassword'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'signUp.label.password'.tr(),
        hintText: 'signUp.holder.enterYourPassword'.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildFirstNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: firstNameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'signUp.message.pleaseEnterFirstName'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'signUp.label.firstName'.tr(),
        hintText: 'signUp.holder.enterYourFistName'.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildLastNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: lastNameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'signUp.message.pleaseEnterLastName'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'signUp.label.lastName'.tr(),
        hintText: 'signUp.holder.enterYourLastName'.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'signUp.message.pleaseEnterEmail'.tr();
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return 'signUp.message.pleaseEnterValidEmail'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'signUp.label.email'.tr(),
        hintText: 'signUp.holder.enterYourEmail'.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/mark_as_unread_black_24dp.svg"),
      ),
    );
  }

  void save() {
    this.isClickSave = true;
    if (_formKey.currentState!.validate()) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => CategorySuccessScreen(
      //     isAddScreen: true,
      //     vData: {
      //       CategoryKey.name: nameController.text,
      //       CategoryKey.remark: remarkController.text
      //     },
      //   )),
      // );
    }
  }

  void checkFormValid() {
    if (isClickSave) {
      _formKey.currentState!.validate();
    }
  }
}
