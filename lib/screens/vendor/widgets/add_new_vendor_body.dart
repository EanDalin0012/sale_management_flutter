import 'package:flutter/material.dart';
import 'package:sale_management/screens/vendor/success_vendor_screen.dart';
import 'package:sale_management/shares/model/key/vendor_key.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';

class AddNewVendorBody extends StatefulWidget {
  const AddNewVendorBody({Key? key}) : super(key: key);

  @override
  _AddNewVendorBodyState createState() => _AddNewVendorBodyState();
}

class _AddNewVendorBodyState extends State<AddNewVendorBody> {
  final _formKey = GlobalKey<FormState>();
  var isClickSave = false;
  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;
  var focusedBorder;
  var emailController = new TextEditingController();
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var remarkController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    style = InputDecorationUtils.textFormFieldStyle();
    labelStyle = InputDecorationUtils.inputDecorationLabelStyle();
    hintStyle = InputDecorationUtils.inputDecorationHintStyle();
    enabledBorder = InputDecorationUtils.enabledBorder();
    focusedBorder = InputDecorationUtils.focusedBorder();
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget>[
              _buildBody(),
              InkWell(
                  onTap: () {
                    KeyboardUtil.hideKeyboard(context);
                    save();
                  },
                  child: WidgetsUtil.overlayKeyBardContainer(
                      text: 'common.label.save'.tr())
              )
            ]
        )
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                    Text('vendor.label.registerVendor'.tr(),
                        style: TextStyleUtils.headingStyle()),
                    Text(
                      'common.label.completeYourDetails'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorsUtils.isDarkModeColor()),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              _buildNameField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildPhoneField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildEmailField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildRemarkField(),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: nameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'vendor.message.pleaseEnterVendorName'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'vendor.label.name'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'vendor.holder.enterVendorName'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPhoneField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      controller: phoneController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'vendor.message.pleaseEnterPhoneNumber'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'vendor.label.phone'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'vendor.holder.enterPhoneNumber'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      style: this.style,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'vendor.label.email'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'vendor.holder.enterEmail'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
            svgPaddingLeft: 15, svgIcon: "assets/icons/mail_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      style: style,
      keyboardType: TextInputType.text,
      controller: remarkController,
      decoration: InputDecoration(
        labelText: 'common.label.remark'.tr(),
        labelStyle: labelStyle,
        hintText: 'common.holder.enterRemark'.tr(),
        hintStyle: hintStyle,
        enabledBorder: enabledBorder,
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  void save() {
    this.isClickSave = true;
    if (_formKey.currentState!.validate()) {
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            SuccessVendorScreen(
              isAddScreen: true,
              vData: {
                VendorKey.name: nameController.text,
                VendorKey.phone: phoneController.text,
                VendorKey.email: emailController.text,
              },
            )),
      );
    }
  }

  void checkFormValid() {
    if (isClickSave) {
      _formKey.currentState!.validate();
    }
  }

}
