import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/constants/text_style.dart';
import 'package:sale_management/shares/model/key/m_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/show_dialog_util.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/over_list_item/over_list_item.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';
import 'add_new_stock_screen.dart';
import 'edit_stock_screen.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  var isNative = false;
  bool isSearch = false;
  late Size size;

  List<dynamic> vData = [];

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
          backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
          appBar: _buildAppBar(),
          floatingActionButton: _floatingActionButton(),
          body: SafeArea(
            child: this.vData.length > 0 ? Column(
                children: <Widget>[
                  OverListItem(
                    text: 'stock.label.stockList'.tr(),
                    length: this.vData.length,
                  ),
                  _buildBody()
                ]
            ) : CircularProgressLoading(),
          )
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      elevation: DefaultStatic.elevationAppBar,
      title: Text('stock.label.stock'.tr()),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(selectIndex: 0)),
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () =>
              setState(() {
                this.isNative = !isNative;
              }),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: size.width - 40,
              height: 65,
              margin: EdgeInsets.only(left: 18),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'search.label.searchName'.tr(),
                text: 'search.label.search'.tr(),
                onChanged: (String value) {},
              ),
            ),
            // _buildFilterByProduct()
          ],
        ),
      ) : null,
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddNewStockScreen()),
        );
      },
      tooltip: 'category.label.addNewCategory'.tr(),
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  Widget _buildBody() {
    return Expanded(
        child: ListView.separated(
          itemCount: vData.length,
          separatorBuilder: (context, index) =>
              Divider(
                  color: ColorsUtils.isDarkModeColor()
              ),
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: this.vData[index]
            );
          },
        )
    );
  }

  Widget _buildListTile({
    required Map dataItem
  }) {
    return ListTile(
      title: Text(dataItem[StockKey.name],
        style: TextStyle(color: ColorsUtils.isDarkModeColor(),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: fontDefault),
      ),
      subtitle: Text(
        dataItem[StockKey.remark],
        style: TextStyle(fontSize: 12,
            fontWeight: FontWeight.w700,
            fontFamily: fontDefault,
            color: primaryColor),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _offsetPopup(dataItem),
        ],
      ),
    );
  }

  Widget _offsetPopup(Map item) =>
      PopupMenuButton<int>(
        itemBuilder: (context) =>
        [
          PopupMenuItem(
              value: 0,
              child: Row(
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.edit, size: 20,
                      color: Colors.purple[900]),
                  SizedBox(width: 10,),
                  Text(
                    'common.label.details'.tr(),
                    style: menuStyle,
                  ),
                ],
              )
          ),
          PopupMenuItem(
              value: 0,
              child: Row(
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.edit, size: 20,
                      color: Colors.purple[900]),
                  SizedBox(width: 10,),
                  Text(
                    'common.label.edit'.tr(),
                    style: menuStyle,
                  ),
                ],
              )
          ),
          PopupMenuItem(
              value: 1,
              child: Row(
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.trash, size: 20,
                      color: Colors.purple[900]),
                  SizedBox(width: 10,),
                  Text(
                    'common.label.delete'.tr(),
                    style: menuStyle,
                  ),
                ],
              )
          ),
        ],
        icon: FaIcon(FontAwesomeIcons.ellipsisV, size: 20,
            color: ColorsUtils.isDarkModeColor()),
        offset: Offset(0, 45),
        onSelected: (value) {
          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditStockScreen(vData: item)),
            );
          } else if (value == 1) {
            _showDialog(item);
          }
        },
      );

  void _showDialog(Map item) {
    ShowDialogUtil.showDialogYesNo(
        buildContext: context,
        title: Text(item[StockKey.name]),
        content: Text('stock.message.doYouWantToDeleteStock'.tr(
            args: [item[StockKey.name]])),
        onPressedYes: () {
          print('onPressedBntRight');
        },
        onPressedNo: () {
          print('onPressedBntLeft');
        }
    );
  }

  _fetchItems() async {
    await Future.delayed(Duration(seconds: 1));
    final data = await rootBundle.loadString(
        'assets/json_data/stock_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['stocks'];
    });
    return this.vData;
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(selectIndex: 0)),
    );
    return Future<bool>.value(true);
  }
}
