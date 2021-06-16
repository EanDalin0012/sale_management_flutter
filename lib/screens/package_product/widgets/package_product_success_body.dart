import 'package:flutter/material.dart';
import 'package:sale_management/screens/package_product/package_product.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/format_date.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/elevate_button_back/elevate_button_back.dart';

class PackageProductSuccessBody extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;

  PackageProductSuccessBody(
      {Key? key, this.isEditScreen, this.isAddScreen, required this.vData})
      : super(key: key);

  @override
  _PackageProductSuccessBodyState createState() =>
      _PackageProductSuccessBodyState();
}

class _PackageProductSuccessBodyState extends State<PackageProductSuccessBody> {
  @override
  Widget build(BuildContext context) {
    Map json = {
      PackageProductKey.id: widget.vData[PackageProductKey.id],
      PackageProductKey.product: widget.vData[PackageProductKey.product],
      PackageProductKey.name: widget.vData[PackageProductKey.name],
      PackageProductKey.productId: widget.vData[PackageProductKey.productId],
      PackageProductKey.quantity: widget.vData[PackageProductKey.quantity],
      PackageProductKey.price: widget.vData[PackageProductKey.price],
      PackageProductKey.remark: widget.vData[PackageProductKey.remark],
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
        Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
              if (widget.isAddScreen == true)
                Text('packageProduct.label.registerPackageProduct'.tr(),
                    style: TextStyleUtils.headingStyle()),
              if(widget.isEditScreen == true)
                Text('packageProduct.label.updatePackageProduct'.tr(),
                    style: TextStyleUtils.headingStyle()
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
              _buildCard(dataItem: json, transactionDate: transactionDate)

            ],
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        ElevatedButtonBack(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PackageProductScreen()),
              );
            }
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildCard({required Map dataItem, required String transactionDate}) {
    Map product = dataItem[PackageProductKey.product];
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
      child: Column(
        children: <Widget>[
          Container(
            height: 175,
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
                  // Text('sale.label.sell'.tr()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text( 'common.label.ID'.tr() + ' :'),
                      Text(dataItem[PackageProductKey.id].toString()),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text( 'packageProduct.label.product'.tr() + ' :'),
                      Text(product[ProductKey.name].toString()),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text( 'packageProduct.label.quantity'.tr() + ' :'),
                      Text(dataItem[PackageProductKey.quantity].toString()),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text( 'packageProduct.label.price'.tr() + ' :'),
                      Text(
                          FormatNumberUtils.usdFormat2Digit(
                              dataItem[PackageProductKey.price].toString()).toString() + ' USD'
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('common.label.remark'.tr() + ' :'),
                      Text(dataItem[PackageProductKey.remark].toString()),
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
