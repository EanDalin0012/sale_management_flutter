import 'package:flutter/material.dart';
import 'package:sale_management/screens/sale/success_sale_screen.dart';
import 'package:sale_management/screens/sale/widgets/build_data_table_sale.dart';
import 'package:sale_management/shares/model/key/member_key.dart';
import 'package:sale_management/shares/model/key/sale_add_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';
import 'package:sale_management/shares/widgets/member_dropdown/member_dropdown.dart';
import 'package:sale_management/shares/widgets/text_form_field_prefix_icon/text_form_field_prefix_icon.dart';
import 'package:sale_management/shares/widgets/two_tab/two_tab.dart';

class ConfirmSaleBody extends StatefulWidget {
  final List<dynamic> vData;
  final ValueChanged<List<dynamic>> onChanged;
  const ConfirmSaleBody({Key? key, required this.vData, required this.onChanged}) : super(key: key);

  @override
  _ConfirmSaleBodyState createState() => _ConfirmSaleBodyState();
}

class _ConfirmSaleBodyState extends State<ConfirmSaleBody> {
  double pay = 0.0;
  double vPay = 0.0;
  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;
  var remarkController = new TextEditingController();
  var customerController = new TextEditingController();
  var phoneController  =new TextEditingController();
  var memberController = new TextEditingController();

  var selectedCustomer = false;
  var isClickConfirm  = false;

  final _formCustomerKey = GlobalKey<FormState>();
  final _formMemberKey = GlobalKey<FormState>();
  var url = DefaultStatic.personUrl;
  int tabIndex = 0;
  late Map member = {};
  @override
  Widget build(BuildContext context) {
    style       = InputDecorationUtils.textFormFieldStyle();
    labelStyle  = InputDecorationUtils.inputDecorationLabelStyle();
    hintStyle   = InputDecorationUtils.inputDecorationHintStyle();
    enabledBorder = InputDecorationUtils.enabledBorder();

    if(this.member.toString() != '{}') {
      this.url = this.member[MemberKey.url].toString();
    }
    this.vPay = 0.0;
    widget.vData.map((e) {
      vPay += double.parse(e[SaleAddItemKey.total].toString());
    }).toList();
    return Column(
      children: <Widget>[
        _buildBody(),
        InkWell(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
              this.isClickConfirm = true;
              if(this.tabIndex == 0 && _formCustomerKey.currentState!.validate()) {
                rout();
              } else if (this.tabIndex == 1 && _formMemberKey.currentState!.validate()) {
                rout();
              }
            },
            child: WidgetsUtil.overlayKeyBardContainer(text: 'common.label.confirm'.tr())
        )

      ],
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
                    Text('sale.label.saleItem'.tr(), style: TextStyleUtils.headingStyle()),
                    Text(
                        'sale.label.completeYourDetails'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorsUtils.isDarkModeColor())
                    ),
                  ],
                ),
              ),
              TwoTabs(
                textTab0: 'sale.label.customer'.tr(),
                textTab1: 'sale.label.member'.tr(),
                onChanged: (tabIndex) {
                  setState(() {
                    this.tabIndex = tabIndex;
                  });
                },
              ),
              Column(
                  children: <Widget>[
                    tabIndex == 0 ? _buildIsCustomerSelected(): _buildIsMemberSelected(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    _buildRemarkField(),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                  ]
              ),
              BuildDataTableSale(vData: widget.vData, onChanged: widget.onChanged),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton () {
    setState(() {
      pay = vPay;
    });
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: InkWell(
            onTap: () {
              this.tabIndex == 0 ? validationCustomerInput(): validationMember();
            },
            child: WidgetsUtil.overlayKeyBardContainer(text: 'common.label.confirm'.tr()),
          ),
        ),
      ],
    );
  }

  TextFormField _buildRemarkField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.text,
      controller: remarkController,
      decoration: InputDecoration(
        labelText: 'common.label.remark'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'common.holder.enterRemark'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/border_color_black_24dp.svg"),
      ),
    );
  }

  Widget _buildIsCustomerSelected() {
    return Form(
      key: _formCustomerKey,
      child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildCustomerField(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildPhoneField(),
              // SizedBox(height: SizeConfig.screenHeight * 0.02),
              // _buildRemarkField(),
            ]
        ),
    );
  }

  Widget _buildIsMemberSelected() {
    return Form(
      key: _formMemberKey,
      child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              _buildMemberField()
            ]
        ),
    );
  }

  TextFormField _buildCustomerField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: customerController,
      onChanged: (value) => validationCustomerInput(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'sale.message.pleaseEnterCustomerName'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'sale.label.customer'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'sale.holder.enterCustomerName'.tr(),
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
      onChanged: (value) => validationCustomerInput(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'sale.message.pleaseEnterPhoneNumber'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'sale.label.phone'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'sale.holder.enterPhoneNumber'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/help_outline_black_24dp.svg"),
      ),
    );
  }

  TextFormField _buildMemberField() {
    return TextFormField(
      style: this.style,
      keyboardType: TextInputType.text,
      controller: memberController,
      onTap: () async {
        final memberBackData = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemberDropdownPage(vMember: this.member)),
        );
        if(memberBackData == null) {
          return;
        }
        setState(() {
          this.member = memberBackData;
          memberController.text = this.member[MemberKey.name];
          validationMember();
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'sale.message.pleaseChooseMember'.tr();
        }
        return null;
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'sale.label.member'.tr(),
        labelStyle: this.labelStyle,
        hintText: 'sale.holder.selectMember'.tr(),
        hintStyle: this.hintStyle,
        enabledBorder: this.enabledBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: TextFormFieldPrefixIcon(url: this.url),
        suffixIcon: CustomSuffixIcon( svgPaddingLeft: 15,svgIcon: "assets/icons/expand_more_black_24dp.svg"),
      ),
    );
  }


  void validationCustomerInput() {
    if(this.isClickConfirm == true) {
      _formCustomerKey.currentState!.validate();
    }

  }

  validationMember() {
    if(this.isClickConfirm == true) {
      this._formMemberKey.currentState!.validate();
    }
  }

  void rout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessSaleScreen(
        vData: {
          SaleAddItemKey.transactionID: 'AXD20210320',
          SaleAddItemKey.total: vPay,
          SaleAddItemKey.member: this.member,
          SaleAddItemKey.customer: this.customerController.text,
          SaleAddItemKey.phone: this.phoneController.text,
          SaleAddItemKey.tableIndex: this.tabIndex,
          SaleAddItemKey.remark: this.remarkController.text
        },
      )),
    );
  }

}
