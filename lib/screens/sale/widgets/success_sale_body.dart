import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/sale/sale_screen.dart';
import 'package:sale_management/shares/model/key/import_add_key.dart';
import 'package:sale_management/shares/model/key/member_key.dart';
import 'package:sale_management/shares/model/key/sale_add_key.dart';
import 'package:sale_management/shares/model/key/sale_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/format_date.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/default_button/default_button.dart';
import 'package:share/share.dart';

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
    Map json = {
      "id": 2,
      "transactionId": "PAY202120020814",
      "total": 100.00,
      "remark": "remark",
      "phoneNumber": "096 65 55 879",
      "customerName": "Chhay Sopheary"
    };
    String transactionDate = "202104131200";
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
          _buildCard(dataItem: json, transactionDate: transactionDate),
          // Center(
          //   child: Column(
          //     children: <Widget>[
          //       SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
          //       Text('sale.label.saleItem'.tr(),
          //           style: TextStyleUtils.headingStyle()),
          //       Text('\n' +
          //           'sale.label.customerName'.tr() + ' : ' + customerName
          //           + '\n' +
          //           'sale.label.transactionID'.tr() + ' : ' +
          //           widget.vData[ImportTransactionKey.transactionID].toString()
          //           + '\n' +
          //           'sale.label.total'.tr() + ' : ' +
          //           FormatNumberUtils.usdFormat2Digit(
          //               widget.vData[ImportAddKey.total].toString()) + ' USD'
          //           + '\n' +
          //           'common.label.remark'.tr() + ' : ' +
          //           widget.vData[ImportAddKey.remark].toString(),
          //         style: TextStyle(
          //             color: ColorsUtils.isDarkModeColor(), fontSize: 18),
          //       )
          //     ],
          //   ),
          // ),

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
              color: Color(0xff273965),
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

  Widget _buildCard({required Map dataItem, required String transactionDate}) {
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
      child: Column(
        children: <Widget>[
          Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFF22293D),
                borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('sale.label.sell'.tr()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('sale.label.customerName'.tr()) + ' :'),
                      Text(dataItem[SaleKey.customerName].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('sale.label.phone'.tr()) + ' :'),
                      Text(dataItem[SaleKey.phoneNumber].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('sale.label.amount'.tr()) + ' :'),
                      Text( FormatNumberUtils.usdFormat2Digit(dataItem[SaleKey.total].toString()).toString() + ' USD'),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('sale.label.transID'.tr()) + ' :'),
                      Text(dataItem[SaleKey.transactionId].toString()),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('common.label.remark'.tr()) + ' :'),
                      Text(dataItem[SaleKey.remark].toString()),
                    ],
                  ),
                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text( FormatDateUtils.dateTime(hhnn: transactionDate.substring(8,12))),
                      Builder(builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            Share.share(
                                'Sell'+"\n"
                                    +'Customer Name : ${dataItem[SaleKey.customerName].toString()}'+"\n"
                                    +'Phone Number : ${dataItem[SaleKey.phoneNumber].toString()}'+"\n"
                                    +'Amount : ${FormatNumberUtils.usdFormat2Digit(dataItem[SaleKey.total].toString()).toString() + ' USD'}'+"\n"
                                    +'Trans ID : ${dataItem[SaleKey.transactionId].toString()}'+"\n"
                                    +'Time : ${FormatDateUtils.dateTime(hhnn: transactionDate.substring(8,12))}'+"\n"
                                    +'Remark : ${dataItem[SaleKey.remark].toString()}'+"\n",
                                subject: 'Look what I made!'
                            );
                          },
                          child: Container(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Color(0xff6E747F),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: Center(child: FaIcon(FontAwesomeIcons.shareAltSquare, size: 15, color: Colors.white,))),
                        );
                      })
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  
}
