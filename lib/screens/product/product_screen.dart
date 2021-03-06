import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/product/add_new_product_screen.dart';
import 'package:sale_management/screens/product/edit_product.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/utils/show_dialog_util.dart';
import 'package:sale_management/shares/widgets/app_bar_actions/appBarActions.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/floating_action_button/floating_action_button.dart';
import 'package:sale_management/shares/widgets/over_list_item/over_list_item.dart';
import 'package:sale_management/shares/widgets/prefix_product/prefix_product.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var isNative = false;
  bool isSearch = false;
  late Size size;

  List<dynamic> vData = [];
  var menuStyle;
  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    this.menuStyle = TextStyle(color: ColorsUtils.isDarkModeColor(),
        fontWeight: FontWeight.w500,
        fontFamily: fontDefault
    );
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
          backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
          appBar: _buildAppBar(),
          body: SafeArea(
            child: this.vData.length > 0 ? GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
              },
              child: Column(
                children: <Widget>[
                  OverListItem(
                    text: 'product.label.productList'.tr(),
                    length: this.vData.length,
                  ),
                  _buildBody()
                ],
              ),
            ) : CircularProgressLoading(),
          ),
          floatingActionButton: WidgetFloatingActionButton(
            onPressed: () {
              KeyboardUtil.hideKeyboard(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewProductScreen()),
              );
            },
          )
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      elevation: DefaultStatic.elevationAppBar,
      title: Text('product.label.product'.tr()),
      leading: IconButton(
        icon: FaIcon(
            FontAwesomeIcons.arrowLeft, color: Colors.white, size: 19
        ),
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(selectIndex: 0)),
          );
        },
      ),
      actions: [
        WidgetAppBarAction(
            onChanged: (v) => setState(() {
              this.isNative = v;
            }),
            isNative: this.isNative
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
                onChanged: (String value) {
                  print(value);
                },
              ),
            ),
            // _buildFilterByProduct()
          ],
        ),
      ) : null,
    );
  }

  Expanded _buildBody() {
    return Expanded(
        child: ListView.separated(
          itemCount: this.vData.length,
          separatorBuilder: (context, index) =>
              Divider(
                color: Colors.purple[900]!.withOpacity(0.5),
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
      title: Text(dataItem[ProductKey.name],
        style: TextStyle(color: ColorsUtils.isDarkModeColor(),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: fontDefault),
      ),
      leading: PrefixProduct(url: dataItem[ProductKey.url].toString()),
      //ListTileLeadingWidget(netWorkURL: dataItem[ProductKey.url],),
      subtitle: Text(
        dataItem[ProductKey.remark].toString(),
        style: TextStyle(fontSize: 12,
            fontWeight: FontWeight.w700,
            fontFamily: fontDefault,
            color: primaryColor),
      ),
      trailing: Column(
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
                      color: ColorsUtils.iConColor()),
                  SizedBox(width: 10,),
                  Text(
                    'common.label.edit'.tr(),
                    style: this.menuStyle,
                  ),
                ],
              )
          ),
          PopupMenuItem(
              value: 1,
              child: Row(
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.trash, size: 20,
                      color: ColorsUtils.iConColor()),
                  SizedBox(width: 10,),
                  Text(
                    'common.label.delete'.tr(),
                    style: this.menuStyle,
                  ),
                ],
              )
          ),
        ],
        icon: FaIcon(
            FontAwesomeIcons.ellipsisV,
            size: 20,
            color: ColorsUtils.iConColor()
        ),
        offset: Offset(0, 40),
        color: ColorsUtils.offsetPopup(),
        onSelected: (value) {
          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProductScreen(vData: item)),
            );
          } else if (value == 1) {
            _showDialog(item);
          }
        },
      );

  void _showDialog(Map item) {
    ShowDialogUtil.showDialogYesNo(
        buildContext: context,
        title: Text(item[ProductKey.name], style: TextStyle(color: ColorsUtils.isDarkModeColor())),
        content: Text('category.message.doYouWantToDeleteProduct'.tr(
            args: [item[ProductKey.name]]), style: TextStyle(color: ColorsUtils.isDarkModeColor())),
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
        'assets/json_data/product_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['products'];
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
