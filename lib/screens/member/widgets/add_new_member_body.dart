import 'package:flutter/material.dart';
import 'package:sale_management/screens/member/member_success_screen.dart';
import 'package:sale_management/shares/model/key/member_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/shares/widgets/text_form_field_prefix_icon/text_form_field_prefix_icon.dart';

class AddNewMemberBody extends StatefulWidget {
  const AddNewMemberBody({Key? key}) : super(key: key);

  @override
  _AddNewMemberBodyState createState() => _AddNewMemberBodyState();
}

class _AddNewMemberBodyState extends State<AddNewMemberBody> {
  final _formKey  = GlobalKey<FormState>();
  var browsController = new TextEditingController();
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var remarkController = new TextEditingController();

  var isClickSave = false;
  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;
  var url = DefaultStatic.personUrl;
  var returnUrl;
  @override
  Widget build(BuildContext context) {
    style       = InputDecorationUtils.textFormFieldStyle();
    labelStyle  = InputDecorationUtils.inputDecorationLabelStyle();
    hintStyle   = InputDecorationUtils.inputDecorationHintStyle();
    enabledBorder = InputDecorationUtils.enabledBorder();
    if(this.returnUrl != null) {
      this.url = this.returnUrl;
    }

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
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              color: ColorsUtils.buttonContainer(),
              child: Center(child: Text('common.label.save'.tr(), style: TextStyle(fontWeight: FontWeight.w700, color: ColorsUtils.buttonColorContainer(), fontSize: 18))),
            ),
          )
        ])
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                    Text('member.label.registerMember'.tr(), style: TextStyleUtils.headingStyle()),
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
              _buildBrowsField(),
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
          return 'member.message.pleaseEnterMemberName'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'member.label.name'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'member.holder.enterMemberName'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
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
          return 'member.holder.enterPhoneNumber'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'member.label.phone'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'member.holder.enterPhoneNumber'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildBrowsField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.text,
      controller: browsController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'common.label.browse'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'common.holder.browseToImage'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: TextFormFieldPrefixIcon(url: this.url),
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/attachment_black_24dp.svg"),
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  void save() {
    this.isClickSave = true;
    if( _formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MemberSuccessScreen(
          isAddScreen: true,
          vData: {
            MemberKey.name: nameController.text,
            MemberKey.phone: phoneController.text,
            MemberKey.url: browsController.text,
            MemberKey.remark: remarkController.text
          },
        )),
      );
    }
  }

  void checkFormValid() {
    if(isClickSave) {
      _formKey.currentState!.validate();
    }
  }
}
