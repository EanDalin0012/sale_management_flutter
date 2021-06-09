import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/import/confirm_import_screen.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/import_add_key.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/model/key/vendor_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/shares/widgets/package_product_dropdown/package_product_dropdown.dart';
import 'package:sale_management/shares/widgets/product_dropdown/product_dropdown.dart';
import 'package:sale_management/shares/widgets/text_form_field_prefix_icon/text_form_field_prefix_icon.dart';
import 'package:sale_management/shares/widgets/vendor_dropdown/vendor_dropdown.dart';

class AddNewImportBody extends StatefulWidget {
  final ValueChanged<List<dynamic>> onAddChanged;

  const AddNewImportBody({Key? key, required this.onAddChanged})
      : super(key: key);

  @override
  _AddNewImportBodyState createState() => _AddNewImportBodyState();
}

class _AddNewImportBodyState extends State<AddNewImportBody> {
  final _formKey = GlobalKey<FormState>();
  var isClickSave = false;
  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;
  var focusedBorder;
  var productController = new TextEditingController();
  var packageProductController = new TextEditingController();
  var vendorController = new TextEditingController();
  var quantityController = new TextEditingController();
  var totalController = new TextEditingController();
  var remarkController = new TextEditingController();
  late Map product = {};
  late Map packageProduct = {};
  late Map vendor = {};
  var helperText = '';
  var url = DefaultStatic.url;
  var isSelectPackageProduct = false;
  List<dynamic> vData = [];

  @override
  Widget build(BuildContext context) {
    style = InputDecorationUtils.textFormFieldStyle();
    labelStyle = InputDecorationUtils.inputDecorationLabelStyle();
    hintStyle = InputDecorationUtils.inputDecorationHintStyle();
    enabledBorder = InputDecorationUtils.enabledBorder();
    focusedBorder = InputDecorationUtils.focusedBorder();

    if (this.product[ProductKey.url].toString() != 'null') {
      this.url = this.product[ProductKey.url].toString();
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
                  child: WidgetsUtil.overlayKeyBardContainer(
                      text: 'common.label.next'.tr())
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
                    Text('import.label.importNewProduct'.tr(),
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _buildAddButton()
                  ]
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
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
          MaterialPageRoute(
              builder: (context) => ProductDropdownPage(vData: this.product)),
        );
        if (product == null) {
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
        labelText: 'import.label.product'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'import.holder.selectProduct'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: TextFormFieldPrefixIcon(url: this.url),
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPackageProductField() {
    return TextFormField(
      style: this.style,
      onTap: () async {
        if (this.product.toString() == '{}') {
          setState(() {
            this.helperText = 'import.message.pleaseSelectProductFirst'.tr();
          });
          return;
        }
        final packageProduct = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              PackageProductDropdownPage(
                product: this.product,
                packageProduct: this.packageProduct,
              )),
        );
        if (packageProduct == null) {
          return;
        }
        setState(() {
          this.packageProduct = packageProduct;
          packageProductController.text =
          this.packageProduct[PackageProductKey.name];
          quantityController.text =
              this.packageProduct[PackageProductKey.quantity].toString();
          var calTotal = (double.parse(quantityController.text) * double.parse(
              this.packageProduct[PackageProductKey.price].toString()))
              .toString();
          totalController.text =
              FormatNumberUtils.usdFormat2Digit(calTotal.toString()).toString();

          this.helperText = 'import.label.price'.tr() + ' : ' +
              FormatNumberUtils.usdFormat2Digit(
                  this.packageProduct[PackageProductKey.price].toString())
                  .toString() + ' USD';
          this.isSelectPackageProduct = true;
          checkFormValid();
        });
      },
      keyboardType: TextInputType.text,
      controller: packageProductController,
      onChanged: (value) => checkFormValid(),
      validator: (value) {
        if (this.product.toString() == 'null') {
          return 'import.message.pleaseSelectProduct'.tr();
        } else if (value!.isEmpty) {
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
        focusedBorder: this.focusedBorder,
        helperText: helperText,
        helperStyle: TextStyle(
            color: isSelectPackageProduct ? Colors.indigo : Colors.red),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: TextFormFieldPrefixIcon(url: this.url),
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildVendorField() {
    return TextFormField(
      style: this.style,
      onTap: () async {
        final vendor = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              VendorDropdownPage(
                  vVendor: this.vendor
              )),
        );
        if (vendor == null) {
          return;
        }
        setState(() {
          this.vendor = vendor;
          vendorController.text = this.vendor[VendorKey.name];
          checkFormValid();
        });
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
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/expand_more_black_24dp.svg"),
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
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
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
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.text,
      controller: this.remarkController,
      decoration: InputDecoration(
        labelText: 'common.label.remark'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'common.holder.enterRemark'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      height: 50,
      width: 110,
      margin: EdgeInsets.only(right: 10),
      child: RaisedButton(
        color: Colors.red,
        textColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FaIcon(FontAwesomeIcons.plusCircle, size: 25, color: Colors.white),
            Center(child: Text('common.label.add'.tr(), style: TextStyle(
                fontFamily: fontDefault,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white),)),
          ],
        ),
        onPressed: () {
          this.isClickSave = true;
          KeyboardUtil.hideKeyboard(context);
          if (_formKey.currentState!.validate()) {
            setState(() {
              Map data = {
                ImportAddKey.product: this.product,
                ImportAddKey.packageProduct: this.packageProduct,
                ImportAddKey.vendor: this.vendor,
                ImportAddKey.quantity: this.quantityController.text,
                ImportAddKey.price: this.packageProduct[PackageProductKey
                    .price],
                ImportAddKey.total: this.totalController.text,
                ImportAddKey.remark: this.remarkController.text
              };
              this.vData.add(data);
              widget.onAddChanged(this.vData);
              this.productController.clear();
              this.packageProductController.clear();
              this.isSelectPackageProduct = false;
              this.vendorController.clear();
              this.quantityController.clear();
              this.totalController.clear();
              this.remarkController.clear();
              this.product = {};
              this.packageProduct = {};
              this.vendor = {};
              this.isClickSave = false;
              this.helperText = '';
            });
          }
        },
      ),
    );
  }


  void save() async {
    this.isClickSave = true;
    if (this.vData.length > 0) {
      final confirmBack = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            ConfirmImportScreen(
              vData: this.vData,
            )),
      );
      if (confirmBack == null) {
        return;
      }
      setState(() {
        this.vData = confirmBack;
        widget.onAddChanged(this.vData);
      });
    }
  }

  void checkFormValid() {
    if (isClickSave) {
      _formKey.currentState!.validate();
    }
  }

}
