import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/m_key.dart';
import 'package:sale_management/shares/model/key/product_import_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/format_date.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/widgets/over_list_item/over_list_item.dart';

class ImportBody extends StatefulWidget {
  final filterByProduct;
  const ImportBody({Key? key, required this.filterByProduct}) : super(key: key);

  @override
  _ImportBodyState createState() => _ImportBodyState();
}

class _ImportBodyState extends State<ImportBody> {

  List<dynamic> vDataProduct = [];
  List<dynamic> vDataAll = [];
  late Size size;
  var color = Color.fromRGBO(58, 66, 86, 1.0);

  @override
  void initState() {
    super.initState();
    // widget.filterByProduct? _fetchItems() : _fetchAllItems();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    widget.filterByProduct? _fetchItems() : _fetchAllItems();
    return SingleChildScrollView(
      // padding: EdgeInsets.only(left: 10),
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          widget.filterByProduct? _buildFilterByProduct(): _buildAllTransaction()
        ],
      ),
    );
  }


  Widget _buildFilterByProduct() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(),
      itemCount: this.vDataProduct.length,
      itemBuilder: (context, index) => _buildPListTile(dataItem: this.vDataProduct[index]),
    );
  }

  Widget _buildPListTile( {
    required Map dataItem
  }) {
    return ListTile(
      title: Text( dataItem[ProductImportKey.name],
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      leading: _buildPLeading(url: dataItem[ProductImportKey.url]),
      subtitle: Text(
        dataItem[ProductImportKey.remark],
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontDefault, color: primaryColor),
      ),
      trailing: Container(
        width: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      dataItem[ProductImportKey.totalQuantity].toString(),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                // _offsetPopup(dataItem),
              ],
            ),

          ],
        ),
      ),
    );
  }


  Widget _buildPLeading({
    required  String url
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundImage:NetworkImage(url),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _buildAllTransaction() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: this.vDataAll.map((e) {
        List<dynamic> mData = e['transactionInfo'];
        var mDataLength = mData.length;
        var i = 0;
        return Container(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              OverListItem(
                text: FormatDateUtils.dateFormat(yyyyMMdd: e[ImportKey.transactionDate].toString()),
                length: mData.length,
              ),

              // Container(
              //   color: Color(0xCD939BA9).withOpacity(0.5),
              //   width: size.width,
              //   padding: EdgeInsets.all(10),
              //   child: Text(
              //     FormatDateUtils.dateFormat(yyyyMMdd: e[ImportKey.transactionDate].toString()),
              //     style: TextStyle(fontFamily: fontDefault, fontWeight: FontWeight.w500, fontSize: 17, color: ColorsUtils.isDarkModeColor()),
              //   ),
              // ),
              Column(
                children: mData.map((item){
                  i += 1;
                  return Container(
                    decoration: mDataLength != i ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xCD939BA9).withOpacity(0.2), width: 1.5),
                        )
                    ) : null,
                    child: _buildListTile(
                        transactionId: item[ImportKey.transactionId].toString(),
                        transactionDate: e[ImportKey.transactionDate].toString(),
                        time: item[ImportKey.time].toString(),
                        total: item[ImportKey.total].toString()
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      }).toList(),
    );
  }


  Widget _buildListTile({
    required String transactionId,
    required String transactionDate,
    required String time,
    required String total,
  }) {
    return ListTile(
      leading: _buildLeading(),
      title: Text(
        transactionId,
        style: TextStyle(color: ColorsUtils.isDarkModeColor(), fontWeight: FontWeight.w500, fontFamily: fontDefault),
      ),
      subtitle: Text(
        FormatDateUtils.dateTime(hhnn: time),
        style: TextStyle(fontFamily: fontDefault, fontWeight: FontWeight.w500, fontSize: 15, color: primaryColor),
      ),
      trailing: Container(
        width: 110,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                FormatNumberUtils.usdFormat2Digit(total).toString() + ' \$',
                style: TextStyle(fontFamily: fontDefault, fontSize: 20, fontWeight: FontWeight.w700, color: ColorsUtils.isDarkModeColor()),
              ),
              SizedBox(width: 10,),
              FaIcon(FontAwesomeIcons.chevronRight,size: 20 , color: Colors.black54.withOpacity(0.5))
            ]
        ),
      ),
    );
  }

  Widget _buildLeading() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.7), width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.transparent,
        child: FaIcon(FontAwesomeIcons.receipt,size: 20 , color: Colors.deepPurple),
      ),
    );
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/product_imports.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vDataProduct = mapItems['imports'];
    });
    return this.vDataProduct;
  }

  _fetchAllItems() async {
    final data = await rootBundle.loadString('assets/json_data/import_transactions.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vDataAll = mapItems['imports'];
    });
    return this.vDataAll;
  }

}
