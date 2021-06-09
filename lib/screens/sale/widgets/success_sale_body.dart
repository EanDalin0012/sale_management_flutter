import 'package:flutter/material.dart';
import 'package:sale_management/screens/sale/sale_screen.dart';
import 'package:sale_management/shares/model/key/import_add_key.dart';
import 'package:sale_management/shares/model/key/member_key.dart';
import 'package:sale_management/shares/model/key/sale_add_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/default_button/default_button.dart';

class SuccessSaleBody extends StatefulWidget {
  final Map vData;

  const SuccessSaleBody({Key? key, required this.vData}) : super(key: key);

  @override
  _SuccessSaleBodyState createState() => _SuccessSaleBodyState();
}

class _SuccessSaleBodyState extends State<SuccessSaleBody> {

  var customerName = '';

  @override
  void initState() {
    super.initState();
    if (widget.vData[SaleAddItemKey.tableIndex] == 0) {
      this.customerName = widget.vData[SaleAddItemKey.customer].toString();
    } else if (widget.vData[SaleAddItemKey.tableIndex] == 1) {
      this.customerName = widget.vData[SaleAddItemKey.member][MemberKey.name];
    }
    print(this.customerName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.screenHeight * 0.07),
          Center(
            child: Image.asset(
              DefaultStatic.assetsSuccessPathImage,
              height: SizeConfig.screenHeight * 0.2, //40%
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.07),

          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text('sale.label.saleItem'.tr(),
                    style: TextStyleUtils.headingStyle()),
                Text('\n' +
                    'sale.label.customerName'.tr() + ' : ' + customerName
                    + '\n' +
                    'sale.label.transactionID'.tr() + ' : ' +
                    widget.vData[ImportTransactionKey.transactionID].toString()
                    + '\n' +
                    'sale.label.total'.tr() + ' : ' +
                    FormatNumberUtils.usdFormat2Digit(
                        widget.vData[ImportAddKey.total].toString()) + ' USD'
                    + '\n' +
                    'common.label.remark'.tr() + ' : ' +
                    widget.vData[ImportAddKey.remark].toString(),
                  style: TextStyle(
                      color: ColorsUtils.isDarkModeColor(), fontSize: 18),
                )
              ],
            ),
          ),

          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Center(
            child: Text(
              'common.label.success'.tr(),
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.7,
            child: DefaultButton(
              elevation: 3,
              text: 'common.label.back'.tr(),
              color: Colors.green[800],
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaleScreen()),
                );
              },
            ),
          ),
          Spacer(),

        ]
    );
  }
}
