import 'package:flutter/material.dart';
import 'package:sale_management/screens/product/product_success_screen.dart';
import 'package:sale_management/shares/model/key/category_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';
import 'package:sale_management/shares/widgets/category_dropdown/category_dropdown.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';

class AddNewProductBody extends StatefulWidget {
  const AddNewProductBody({Key? key}) : super(key: key);

  @override
  _AddNewProductBodyState createState() => _AddNewProductBodyState();
}

class _AddNewProductBodyState extends State<AddNewProductBody> {
  final _formKey  = GlobalKey<FormState>();
  var isClickSave = false;

  var nameController = new TextEditingController();
  var categoryController = new TextEditingController();
  var browController = new TextEditingController();
  var remarkController = new TextEditingController();
  late Map categoryMap = {};

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
              mySave();
            },
            child: WidgetsUtil.overlayKeyBardContainer(text: 'common.label.save'.tr())
          )
        ],
      ),
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
                    Text('product.label.registerProduct'.tr(), style: TextStyleUtils.headingStyle()),
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
              _buildCategoryField(),
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
      controller: this.nameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'product.message.pleaseEnterName'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'product.label.name'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'product.holder.enterProductName'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      onTap: () async {
        final category = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryDropdownPage(vCategory: this.categoryMap,)),
        );
        if(category == null) {
          return;
        }
        setState(() {
          this.categoryMap = category;
          this.categoryController.text = this.categoryMap[CategoryKey.name];
          checkFormValid();
        });
      },
      style: this.style,
      keyboardType: TextInputType.text,
      controller: categoryController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'product.message.pleaseChooseCategory'.tr();
        }
        return null;
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'product.label.category'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'product.holder.selectCategory'.tr(),
        hintStyle: this.hintStyle ,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildBrowsField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.text,
      controller: browController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'product.label.browse'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'product.holder.browseToImage'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
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

  void mySave() {
    this.isClickSave = true;
    if( _formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductSuccessScreen(
          isAddScreen: true,
          vData: {
            ProductKey.name: this.nameController.text,
            ProductKey.category: categoryController.text,
            ProductKey.remark: this.remarkController.text,
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
