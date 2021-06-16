import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/product/product_screen.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/sale_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/format_date.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/elevate_button_back/elevate_button_back.dart';

class ProductSuccessBody extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;

  ProductSuccessBody(
      {Key? key, this.isEditScreen, this.isAddScreen, required this.vData})
      : super(key: key);

  @override
  _ProductSuccessBodyState createState() => _ProductSuccessBodyState();
}

class _ProductSuccessBodyState extends State<ProductSuccessBody> {
  @override
  Widget build(BuildContext context) {
    Map json = {
      "id": 2,
      "transactionId": "PAY202120020814",
      "total": 100.00,
      "remark": "remark",
      "phoneNumber": "Le",
      "customerName": "Pichy P-White"
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
        //SizedBox(height: SizeConfig.screenHeight * 0.07),

        Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
              if (widget.isAddScreen == true)
                Text('product.label.registerProduct'.tr(),
                    style: TextStyleUtils.headingStyle()),
              if(widget.isEditScreen == true)
                Text('product.label.updateProduct'.tr(),
                    style: TextStyleUtils.headingStyle()),

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

              _buildCard(dataItem: json, transactionDate: transactionDate),

            ],
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        ElevatedButtonBack(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductScreen()),
            );
          }
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildCard({required Map dataItem, required String transactionDate}) {
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text( 'common.label.ID'.tr() + ' :'),
                      Text(dataItem[SaleKey.transactionId].toString()),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text( 'product.label.productName'.tr() + ' :'),
                      Text(dataItem[SaleKey.customerName].toString()),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('product.label.category'.tr() + ' :'),
                      Text(dataItem[SaleKey.phoneNumber].toString()),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
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
                      Text( FormatDateUtils.dateFormat(yyyyMMdd: transactionDate.substring(0,8)) + ' '+ FormatDateUtils.dateTime(hhnn: transactionDate.substring(8,12)) + ' AM'),
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
