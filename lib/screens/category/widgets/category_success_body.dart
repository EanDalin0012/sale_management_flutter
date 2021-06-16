import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/category/category_screen.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/category_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/format_date.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:easy_localization/easy_localization.dart';

class CategorySuccessBody extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;
  CategorySuccessBody({Key? key, this.isEditScreen, this.isAddScreen, required this.vData}) : super(key: key);

  @override
  _CategorySuccessBodyState createState() => _CategorySuccessBodyState();
}

class _CategorySuccessBodyState extends State<CategorySuccessBody> {

  @override
  Widget build(BuildContext context) {
    Map json = {
      CategoryKey.id: widget.vData[CategoryKey.id],
      CategoryKey.name: widget.vData[CategoryKey.name],
      CategoryKey.remark: widget.vData[CategoryKey.remark]
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
                Text('category.label.registerCategory'.tr(),
                    style: TextStyleUtils.headingStyle()),
              if(widget.isEditScreen == true)
                Text('category.label.updateCategory'.tr(),
                    style: TextStyleUtils.headingStyle()),
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
        _buildAddButton(),
        Spacer(),
      ],
    );
  }

  Widget  _buildAddButton() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - getProportionateScreenWidth(70),
      child: RaisedButton(
        color: Color(0xff273965),
        textColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Stack(
          children: <Widget>[
            Center(child: Text('common.label.back'.tr(), style: TextStyle(
                fontFamily: fontDefault,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white),)
            ),
            Positioned(
                left: 0,
                top: 12.5,
                child: FaIcon(FontAwesomeIcons.arrowCircleLeft, size: 25, color: Colors.white)
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryScreen()),
          );
        },
      ),
    );
  }

  Widget _buildCard({required Map dataItem, required String transactionDate}) {
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
      child: Column(
        children: <Widget>[
          Container(
            height: 130,
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
                      Text(dataItem[CategoryKey.id].toString()),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text( 'category.label.categoryName'.tr() + ' :'),
                      Text(dataItem[CategoryKey.name].toString()),
                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('common.label.remark'.tr() + ' :'),
                      Text(dataItem[CategoryKey.remark].toString()),
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
