import 'package:flutter/material.dart';
import 'package:sale_management/screens/import/widgets/build_data_table.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/input_decoration.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';
import 'package:sale_management/shares/widgets/custom_suffix_icon/custom_suffix_icon.dart';

class ConfirmImportBody extends StatefulWidget {
  final List<dynamic> vData;
  final ValueChanged<List<dynamic>> onChanged;
  const ConfirmImportBody({Key? key, required this.vData, required this.onChanged}) : super(key: key);

  @override
  _ConfirmImportBodyState createState() => _ConfirmImportBodyState();
}

class _ConfirmImportBodyState extends State<ConfirmImportBody> {

  double pay = 0.0;
  double vPay = 0.0;
  var style;
  var labelStyle;
  var hintStyle;
  var enabledBorder;
  var remarkController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    style       = InputDecorationUtils.textFormFieldStyle();
    labelStyle  = InputDecorationUtils.inputDecorationLabelStyle();
    hintStyle   = InputDecorationUtils.inputDecorationHintStyle();
    enabledBorder = InputDecorationUtils.enabledBorder();

    return Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Import Items", style: TextStyleUtils.headingStyle()),
                Text(
                  "Complete your details. \n Please check your items ready then click confirm.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorsUtils.isDarkModeColor())
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  _buildRemarkField(),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                ]
            ),
          ),
            Expanded(child: BuildDataTable(vData: widget.vData, onChanged: widget.onChanged)),
          _buildConfirmButton ()
        ]
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

  Widget _buildConfirmButton () {
    setState(() {
      pay = vPay;
    });
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ImportSuccessScreen(
            //     isAddScreen: true,
            //     vData: {
            //       ImportKey.transactionId: 'BAE20210939',
            //       ImportKey.total: this.total
            //     },
            //   )),
            // );
          },
          child: WidgetsUtil.overlayKeyBardContainer(text: 'common.label.confirm'.tr()),
        ),
      ],
    );
  }


}
