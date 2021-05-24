import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/category_success_screen.dart';
import 'package:sale_management/shares/model/key/category_key.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';

class AddBewCategoryBody extends StatefulWidget {
  const AddBewCategoryBody({Key? key}) : super(key: key);

  @override
  _AddBewCategoryBodyState createState() => _AddBewCategoryBodyState();
}

class _AddBewCategoryBodyState extends State<AddBewCategoryBody> {

  final _formKey  = GlobalKey<FormState>();
  var isClickSave = false;
  var nameController    = new TextEditingController();
  var remarkController  = new TextEditingController();
  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;
  @override
  Widget build(BuildContext context) {
    style       = InputDecorationUtils.textFormFieldStyle();
    labelStyle  = InputDecorationUtils.inputDecorationLabelStyle();
    hintStyle   = InputDecorationUtils.inputDecorationHintStyle();
    enabledBorder = InputDecorationUtils.enabledBorder();
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
            ]
        )
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
                    Text('category.label.registerCategory'.tr(), style: TextStyleUtils.headingStyle()),
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
              _buildRemarkField(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      style: style,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: nameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'category.message.pleaseEnterCategoryName'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'category.label.name'.tr(),
        labelStyle: labelStyle,
        hintText: 'category.holder.enterCategoryName'.tr(),
        hintStyle: hintStyle,
        enabledBorder: enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
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
      print('validate');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategorySuccessScreen(
          isAddScreen: true,
          vData: {
            CategoryKey.name: nameController.text,
            CategoryKey.remark: remarkController.text
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