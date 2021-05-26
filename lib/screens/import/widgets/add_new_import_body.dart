import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/shares/widgets/product_dropdown/product_dropdown.dart';
import 'package:sale_management/shares/widgets/text_form_field_prefix_icon/text_form_field_prefix_icon.dart';

class AddNewImportBody extends StatefulWidget {
  const AddNewImportBody({Key? key}) : super(key: key);

  @override
  _AddNewImportBodyState createState() => _AddNewImportBodyState();
}

class _AddNewImportBodyState extends State<AddNewImportBody> {
  final _formKey  = GlobalKey<FormState>();
  var isClickSave = false;
  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;

  var productController = new TextEditingController();
  var packageProductController = new TextEditingController();
  var vendorController = new TextEditingController();
  var quantityController = new TextEditingController();
  var totalController = new TextEditingController();
  var remarkController = new TextEditingController();
  late Map product = {};
  var helperText = 'Please select product first.';
  var url = DefaultStatic.url;
  var isSelectPackageProduct = false;

  @override
  Widget build(BuildContext context) {
    style       = InputDecorationUtils.textFormFieldStyle();
    labelStyle  = InputDecorationUtils.inputDecorationLabelStyle();
    hintStyle   = InputDecorationUtils.inputDecorationHintStyle();
    enabledBorder = InputDecorationUtils.enabledBorder();
    if(this.product[ProductKey.url].toString() != 'null') {
      this.url = this.product[ProductKey.url].toString();
    }

    return Form(
      key: _formKey,
        child: Column(
          children: <Widget>[
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
                    Text('import.label.importNewProduct'.tr(), style: TextStyleUtils.headingStyle()),
                    Text(
                      'common.label.completeYourDetails'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorsUtils.isDarkModeColor()),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              _buildProductField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildPackageProductField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildVendorField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildQuantityField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildTotalField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildRemarkField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildProductField() {
    return TextFormField(
      style: this.style,
      onTap: () async {
        final product = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDropdownPage(vData: this.product)),
        );
        if(product == null) {
          return;
        }
        setState(() {
          this.product = product;
          productController.text = this.product[ProductKey.name];
          this.helperText = '';
          checkFormValid();
        });
      },
      keyboardType: TextInputType.text,
      controller: productController,
      onChanged: (value) => checkFormValid(),
      readOnly: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'import.message.pleaseSelectProduct'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'import.holder.product'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'import.label.selectProduct'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: TextFormFieldPrefixIcon(url: this.url),
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPackageProductField() {
    return TextFormField(
      style: this.style,
      onTap: () async {
        // if(this.product != null) {
        //   final packageProduct = await Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => PackageProductPage(
        //       product: this.product,
        //       packageProduct: this.packageProduct,
        //     )),
        //   );
        //   if(packageProduct == null) {
        //     return;
        //   }
        //   setState(() {
        //     this.packageProduct = packageProduct;
        //     packageProductController.text = this.packageProduct[PackageProductKey.name];
        //     quantityController.text = this.packageProduct[PackageProductKey.quantity].toString();
        //     var calTotal = (double.parse(quantityController.text) * double.parse(this.packageProduct[PackageProductKey.price].toString())).toString();
        //     totalController.text = FormatNumber.usdFormat2Digit(calTotal.toString()).toString();
        //
        //     this.helperText = 'Price : '+FormatNumber.usdFormat2Digit(this.packageProduct[PackageProductKey.price].toString()).toString() + ' USD';
        //     this.isSelectPackageProduct = false;
        //     checkFormValid();
        //   });
        // } else {
        //   setState(() {
        //     this.isSelectPackageProduct = true;
        //   });
        // }

      },
      keyboardType: TextInputType.text,
      controller: packageProductController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if(this.product == null) {
          return 'import.message.pleaseSelectProduct'.tr();
        } else if (this.product != null && value!.isEmpty) {
          return 'import.message.pleaseSelectPackageProduct'.tr();
        }
        return null;
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'import.label.packageProduct'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'import.holder.selectPackageProduct'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        helperText: helperText,
        helperStyle: TextStyle(color: isSelectPackageProduct ? Colors.redAccent : dropColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: TextFormFieldPrefixIcon(url: this.url),
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildVendorField() {
    return TextFormField(
      style: this.style,
      onTap: () async {
        // final vendor = await Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => VendorDropDownPage(
        //       vVendor: this.vendor
        //   )),
        // );
        // if(vendor == null) {
        //   return;
        // }
        // setState(() {
        //   this.vendor = vendor;
        //   vendorController.text = this.vendor[VendorKey.name];
        //   checkFormValid();
        // });
      },
      keyboardType: TextInputType.text,
      controller: vendorController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'import.message.pleaseSelectVendor'.tr();
        }
        return null;
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'import.label.vendor'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'import.holder.selectVendor'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildQuantityField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: quantityController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'import.message.pleaseEnterQuantity'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'import.label.quantity'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'import.holder.enterQuantity'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildTotalField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: totalController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'import.message.pleaseEnterTotal'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'import.label.total'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'import.holder.enterTotal'.tr(),
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
    if(isClickSave) {
      _formKey.currentState!.validate();
    }
  }

}
