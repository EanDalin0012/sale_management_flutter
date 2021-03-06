import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sale_management/screens/package_product/package_product_success_screen.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/shares/widgets/product_dropdown/product_dropdown.dart';
import 'package:sale_management/shares/widgets/text_form_field_prefix_icon/text_form_field_prefix_icon.dart';

class AddNewPackageProductBody extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  const AddNewPackageProductBody({Key? key, required this.onChanged}) : super(key: key);

  @override
  _AddNewPackageProductBodyState createState() =>
      _AddNewPackageProductBodyState();
}

class _AddNewPackageProductBodyState extends State<AddNewPackageProductBody> {
  final _formKey = GlobalKey<FormState>();
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
  var focusedBorder;
  var url = DefaultStatic.url;
  var _isLoading = false;

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
    return LoadingOverlay(
      isLoading: this._isLoading,
      opacity: 0.5,
      progressIndicator: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Text('Loading'),
        ],
      ),
      child: Form(
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

      ),
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
                    Center(
                      child: Text('packageProduct.label.registerPackageProduct'.tr(),
                          style: TextStyleUtils.headingStyle()
                      ),
                    ),
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
      style: this.style,
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
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
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
          this.productNameController.text = this.product[ProductKey.name];
          checkFormValid();
        });
      },
      style: this.style,
      readOnly: true,
      controller: this.productNameController,
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
      controller: this.qtyController,
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
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildPriceField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: this.priceController,
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
        focusedBorder: this.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgPaddingLeft: 15,
            svgIcon: "assets/icons/help_outline_black_24dp.svg"),
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
      widget.onChanged(true);
      setState(() {
        _isLoading = true;
      });

      rout();

    }
  }

  void checkFormValid() {
    if (isClickSave) {
      _formKey.currentState!.validate();
    }
  }

  Future<void> rout() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          PackageProductSuccessScreen(
            isAddScreen: true,
            vData: {
              PackageProductKey.id: "ABC20210212",
              PackageProductKey.product: this.product,
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
