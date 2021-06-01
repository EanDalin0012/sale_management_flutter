import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/sale/widgets/sale_details.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/constants/text_style.dart';
import 'package:sale_management/shares/model/key/sale_key.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/format_date.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/over_list_item/over_list_item.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';

import 'add_new_sale_screen.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);

  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  var isNative = false;
  late Size size ;
  List<dynamic> vData = [];


  @override
  void initState() {
    super.initState();
    this._fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop:  () => onBackPress(),
      child: Scaffold(
        backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
        appBar: _buildAppBar(),
        floatingActionButton: _floatingActionButton(),
        body: SafeArea(
          child: this.vData.length > 0 ? _buildBody() : CircularProgressLoading()
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: this.vData.map((e) {
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
                      text: FormatDateUtils.dateFormat(yyyyMMdd: e[SaleKey.transactionDate].toString()),
                      length: mData.length,
                    ),
                    Column(
                      children: mData.map((item) {
                        i += 1;
                        return Container(
                          decoration: mDataLength != i ? BoxDecoration(
                              border: Border(bottom: BorderSide(color: Color(0xCD939BA9).withOpacity(0.2), width: 1.5),)
                          ) : null,
                          child: _buildListTile(
                              transactionDate: e[SaleKey.transactionDate].toString(),
                              time: item[SaleKey.time].toString(),
                              dataItems: item
                          ),
                        );
                      }).toList(),
                    )
                  ]
              ),
            );
          }).toList()
      ),
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      elevation: DefaultStatic.elevationAppBar,
      title: Text('sale.label.sale'.tr()),
      leading: SizedBox(),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            this.isNative = !isNative;
          }),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: size.width - 40,
              height: 65,
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'search.label.searchName'.tr(),
                text: 'search.label.searchName'.tr(),
                onChanged: (value) {
                },
              ),
            ),
          ],
        ),
      ): null,
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddNewSaleScreen()),
        );
      },
      tooltip: 'product.label.addNewProduct'.tr(),
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }


  Widget _buildListTile({
    required String transactionDate,
    required String time,
    required Map dataItems
  }) {
    return ListTile(
      leading: _buildLeading(),
      title: Text(
        dataItems[SaleKey.transactionId].toString(),
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
                FormatNumberUtils.usdFormat2Digit(dataItems[SaleKey.total].toString()).toString() + ' \$',
                style: TextStyle(fontFamily: fontDefault, fontSize: 20, fontWeight: FontWeight.w700, color: ColorsUtils.isDarkModeColor()),
              ),
              SizedBox(width: 10,),
              Container(
                width: 10,
                child: _offsetPopup(dataItems),
              )
            ]
        ),
      ),
    );
  }

  Widget _buildLeading() {
    var colorBorder = DarkMode.isDarkMode ? Colors.blueGrey.withOpacity(0.4) :Color(0xFFe4e6eb);
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(color: colorBorder, width: 5),
      ),
      child: Image.asset('assets/icons/sale.png'),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    return Future<bool>.value(true);
  }


  Widget _offsetPopup(Map item) => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 0,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.edit,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                // 'common.label.edit'.tr(),
                'Details',
                style: menuStyle,
              ),
            ],
          )
      ),
      PopupMenuItem(
          value: 0,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.edit,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                // 'common.label.edit'.tr(),
                'Cancel Transaction',
                style: menuStyle,
              ),
            ],
          )
      ),
      PopupMenuItem(
          value: 1,
          child: Row(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.trash,size: 20,color: Colors.purple[900]),
              SizedBox(width: 10,),
              Text(
                'common.label.delete'.tr(),
                style: menuStyle,
              ),
            ],
          )
      ),
    ],
    icon: FaIcon(FontAwesomeIcons.ellipsisV,size: 20,color: ColorsUtils.isDarkModeColor()),
    offset: Offset(0, 45),
    onSelected: (value) {
      if(value == 0) {
        _showModelSheet(item);
      } else if (value == 1) {
        // _showDialog(item);
      }
    },
  );

  _showModelSheet(Map item) {
    var orientation = MediaQuery.of(context).orientation;
    double height = (MediaQuery.of(context).copyWith().size.height * 0.9);
    setState(() {
      if(orientation != Orientation.portrait){
        height = MediaQuery.of(context).copyWith().size.height * 0.5;
      }
    });

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) {
          return Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: Colors.deepPurpleAccent.withOpacity(0.5)
            ),
            child: SaleDetails(
              vData: item,
            ),
          );
        });
  }


  _fetchItems() async {
    await Future.delayed(Duration(seconds: 1));
    final data = await rootBundle.loadString('assets/json_data/sale_transaction_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['transactionList'];
    });
    return this.vData;
  }

}
