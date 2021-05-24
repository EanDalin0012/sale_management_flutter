import 'package:flutter/material.dart';
import 'package:sale_management/screens/package_product/package_product_success_screen.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/shares/widgets/prefix_product/prefix_product.dart';
import 'package:sale_management/shares/widgets/product_dropdown/product_dropdown.dart';

class AddNewPackageProductBody extends StatefulWidget {
  const AddNewPackageProductBody({Key? key}) : super(key: key);

  @override
  _AddNewPackageProductBodyState createState() => _AddNewPackageProductBodyState();
}

class _AddNewPackageProductBodyState extends State<AddNewPackageProductBody> {
  final _formKey  = GlobalKey<FormState>();

  var productNameController = new TextEditingController();
  var productController = new TextEditingController();
  var nameController = new TextEditingController();
  var qtyController = new TextEditingController();
  var priceController = new TextEditingController();
  var remarkController = new TextEditingController();
  late Map product = {};

  var isClickSave = false;
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
                    Text('packageProduct.label.registerPackageProduct'.tr(), style: TextStyleUtils.headingStyle()),
                    Text(
                      'common.label.completeYourDetails'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorsUtils.isDarkModeColor()),
                    ),

                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    _buildPackageNameField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    _buildProductField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    _buildQuantityField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    _buildPriceField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    _buildRemarkField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildPackageNameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: nameController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'packageProduct.message.pleaseEnterPackageProduct'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'packageProduct.label.name'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'packageProduct.holder.enterPackageProductName'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  Widget _buildProductField() {
    return TextFormField(
      onTap: () async {
        final product = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDropdownPage(vData: this.product,)),
        );
        if(product == null) {
          return;
        }
        setState(() {
          this.product = product;
          productNameController.text = this.product[ProductKey.name];
          checkFormValid();
        });
      },
      readOnly: true,
      controller: productNameController,
      keyboardType: TextInputType.text,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'packageProduct.message.pleaseSelectProduct'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'packageProduct.label.product'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'product.label.selectProduct'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: this.product != {} ? PrefixProduct(url: this.product[ProductKey.url].toString()) : null,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildQuantityField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'packageProduct.message.pleaseEnterQuantity'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'packageProduct.label.quantity'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'packageProduct.holder.enterQuantity'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPriceField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: priceController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'packageProduct.message.pleaseEnterPrice'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'packageProduct.label.price'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'packageProduct.holder.enterPrice'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PackageProductSuccessScreen(
          isAddScreen: true,
          vData: {
            PackageProductKey.name: this.nameController.text,
            PackageProductKey.productId: this.product[ProductKey.id],
            PackageProductKey.quantity: this.qtyController.text,
            PackageProductKey.price: this.priceController.text,
            PackageProductKey.remark: this.remarkController.text
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
