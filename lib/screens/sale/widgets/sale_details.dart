import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/shares/model/key/sale_details_key.dart';
import 'package:sale_management/shares/model/key/sale_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/prefix_product/prefix_product.dart';

class SaleDetails extends StatefulWidget {
  final Map vData;
  const SaleDetails({Key? key, required this.vData}) : super(key: key);

  @override
  _SaleDetailsState createState() => _SaleDetailsState();
}

class _SaleDetailsState extends State<SaleDetails> {
  List<dynamic> vData = [];
  var i = 0;
  var total = 0.0;
  var style;
  double sizedBoxHeight = 10.0;
  @override
  void initState() {
    super.initState();
    this._fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    this.style = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ColorsUtils.isDarkModeColor());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: ColorsUtils.scaffoldBackgroundColor()
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _widgetStack(context),
              drawerHandler(),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Container(
                     child: Text('sale.label.transactionID'.tr()+ ' :', style: style),
                   ),
                   Text(
                     widget.vData[SaleKey.transactionId],
                     style: style,
                   ),
                 ],
                ),
                SizedBox(height: this.sizedBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text('sale.label.total'.tr()+ ' :', style: style),
                    ),
                    Text(
                      FormatNumberUtils.usdFormat2Digit(widget.vData[SaleDetailsKey.total].toString()) + ' USD'.toString(),
                      style: style,
                    ),
                  ],
                ),
                SizedBox(height: this.sizedBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text('sale.label.customerName'.tr()+ ' :', style: style),
                    ),
                    Text(
                      widget.vData[SaleKey.customerName].toString(),
                      style: style,
                    ),
                  ],
                ),
                SizedBox(height: this.sizedBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text('sale.label.phone'.tr()+ ' :', style: style),
                    ),
                    Text(
                      widget.vData[SaleKey.phoneNumber].toString(),
                      style: style,
                    ),
                  ],
                ),
                SizedBox(height: this.sizedBoxHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text('sale.label.transactionDate'.tr()+ ' :', style: style),
                    ),
                    Text(
                      widget.vData[SaleKey.transactionDate],
                      style: style,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text('sale.label.sellProduct'.tr()+ ' :'),
          ),
          this.vData.length> 0 ? _buildBody() : CircularProgressLoading(),

        ],
      ),
    );
  }

  Widget _widgetStack(BuildContext context) {
    return Stack(
        children: [
          Container(
            width: double.infinity,
            height: 35.0,
            child: Center(
                child: Text('sale.label.saleDetails'.tr(),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: ColorsUtils.isDarkModeColor())
                ) // Your desired title
            ),
          ),
          Positioned(
              left: 0.0,
              top: 0.0,
              child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.arrowLeft,size: 20 , color: ColorsUtils.isDarkModeColor()), // Your desired icon
                  onPressed: (){
                    Navigator.of(context).pop();
                  }
              )
          )
        ]
    );
  }

  drawerHandler() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 4,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xffd9dbdb)
      ),
    );
  }

  Widget _buildBody() {
    i = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
              children: <Widget>[
                _buildDataTable(),
              ]
          ),
        ),
      ),
    );
  }
  Widget _buildDataTable() {
    var textStyle = TextStyle(color: ColorsUtils.isDarkModeColor());
    return DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text('import.label.no'.tr(), style: textStyle),
          ),
          DataColumn(
            label: Text('import.label.product'.tr(),style: textStyle),
          ),
          DataColumn(
            label: Text('import.label.quantity'.tr(), style: textStyle),
          ),
          DataColumn(
            label: Text('import.label.total'.tr(), style: textStyle),
          ),
        ],
        rows: this.vData.map((e) {
          i += 1;
          return DataRow(
              cells: <DataCell>[
                DataCell(Text(i.toString(), style: textStyle)),
                DataCell(
                    Row(
                        children: <Widget>[
                          Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
                              child: PrefixProduct(url:  e[SaleDetailsKey.url].toString())),
                          SizedBox(width: 10),
                          Text(e[SaleDetailsKey.name].toString(), style: textStyle)
                        ]
                    )
                ),
                DataCell(Text(e[SaleDetailsKey.quantity].toString(), style: textStyle)),
                DataCell(Text(e[SaleDetailsKey.total].toString() + ' \$', style: textStyle))
              ]
          );
        }

        ).toList()
    );
  }

  _fetchItems() async {
    await Future.delayed(Duration(seconds: 1));
    final data = await rootBundle.loadString('assets/json_data/sale_details_of_transaction.json');
    Map mapItems = jsonDecode(data);
    print(mapItems.toString());
    setState(() {
      this.vData = mapItems['saleDetails'];
    });
    return this.vData;
  }


}
