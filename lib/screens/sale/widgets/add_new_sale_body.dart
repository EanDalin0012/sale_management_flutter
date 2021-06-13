import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/sale/confirm_sale_screen.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/model/key/sale_add_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/utils/show_dialog_util.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/shares/widgets/package_product_dropdown/package_product_dropdown.dart';
import 'package:sale_management/shares/widgets/product_dropdown/product_dropdown.dart';
import 'package:sale_management/shares/widgets/text_form_field_prefix_icon/text_form_field_prefix_icon.dart';

class AddNewSaleBody extends StatefulWidget {
  final ValueChanged<List<dynamic>> onAddChanged;

  const AddNewSaleBody({Key? key, required this.onAddChanged})
      : super(key: key);

  @override
  _AddNewSaleBodyState createState() => _AddNewSaleBodyState();
}

class _AddNewSaleBodyState extends State<AddNewSaleBody> {
  final _formKey = GlobalKey<FormState>();
  List<dynamic> vData = [];
  late Map product = {};
  late Map packageProduct = {};
  var url = DefaultStatic.url;
  var helperText = '';
  var isSelectPackageProduct = false;

  var isClickSave = false;
  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;
  var focusedBorder;
  var packageProductController = new TextEditingController();
  var productController = new TextEditingController();
  var quantityController = new TextEditingController();
  var totalController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    this.style = InputDecorationUtils.textFormFieldStyle();
    this.labelStyle = InputDecorationUtils.inputDecorationLabelStyle();
    this.hintStyle = InputDecorationUtils.inputDecorationHintStyle();
    this.enabledBorder = InputDecorationUtils.enabledBorder();
    this.focusedBorder = InputDecorationUtils.focusedBorder();
    this.url = DefaultStatic.url;
    if (this.product.toString() != '{}') {
      this.url = this.product[ProductKey.url].toString();
    }

    return Form(
        key: this._formKey,
        child: Column(
            children: <Widget>[
              _buildBody(),
              InkWell(
                  onTap: () {
                    KeyboardUtil.hideKeyboard(context);
                    next();
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
                    Text('sale.label.saleItem'.tr(),
                        style: TextStyleUtils.headingStyle()),
                    Text(
                      'common.label.completeYourDetails'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorsUtils.isDarkModeColor()),
                    ),

                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                    _buildProductField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    _buildPackageProductField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    _buildQuantityField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    _buildTotalField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          _buildAddButton()
                        ]
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildProductField() {
    return TextFormField(
      onTap: () async {
        final product = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDropdownPage(vData: this.product,)),
        );
        if (product == null) {
          return;
        }
        setState(() {
          this.product = product;
          this.productController.text = this.product[ProductKey.name];
          checkFormValid();
        });
      },
      style: this.style,
      readOnly: true,
      controller: this.productController,
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
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: this.product != {}
            ? TextFormFieldPrefixIcon(url: this.url)
            : null,
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


  Future<void> next() async {
    this.isClickSave = true;
    if (this.vData.length > 0) {
      final confirmBack = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            ConfirmSaleScreen(
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
    } else {
      ShowDialogUtil.dialog(
          buildContext: context,
          content: Text("Your sale items is zero. Please add sale items",style: TextStyle(color: Colors.white))
      );
    }
  }

  Widget _buildAddButton() {
    return Container(
      height: 50,
      width: 110,
      margin: EdgeInsets.only(right: 10),
      child: RaisedButton(
        color: Color(0xff273965),
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
                fontWeight: FontWeight.w500,
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
                SaleAddItemKey.product: this.product,
                SaleAddItemKey.packageProduct: this.packageProduct,
                SaleAddItemKey.quantity: this.quantityController.text,
                SaleAddItemKey.price: this.packageProduct[PackageProductKey
                    .price],
                SaleAddItemKey.total: this.totalController.text,
              };
              this.vData.add(data);
              widget.onAddChanged(this.vData);
              this.productController.clear();
              this.packageProductController.clear();
              this.isSelectPackageProduct = false;
              this.quantityController.clear();
              this.totalController.clear();
              this.product = {};
              this.packageProduct = {};
              this.isClickSave = false;
              this.helperText = '';
            });
          }
        },
      ),
    );
  }

  void checkFormValid() {
    if (isClickSave) {
      _formKey.currentState!.validate();
    }
  }

}
