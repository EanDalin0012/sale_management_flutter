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
import 'package:sale_management/shares/constants/text_style.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/show_dialog_util.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
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
  late Size size ;
  List<dynamic> vData = [];

  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
        appBar: _buildAppBar(),
        body: SafeArea(
          child: this.vData.length > 0 ? Column(
            children: <Widget>[
              OverListItem(
                text: 'product.label.productList'.tr(),
                length: this.vData.length,
              ),
              _buildBody()
            ],
          ): CircularProgressLoading(),
        ),
        floatingActionButton: _floatingActionButton()
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      elevation: DefaultStatic.elevationAppBar,
      title: Text('product.label.product'.tr()),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
      ),
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
              margin: EdgeInsets.only(left: 18),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'search.label.searchName'.tr(),
                text: 'search.label.search'.tr(),
                onChanged: (String value) {  },
              ),
            ),
            // _buildFilterByProduct()
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
          MaterialPageRoute(builder: (context) => AddNewProductScreen()),
        );
      },
      tooltip: 'product.label.addNewProduct'.tr(),
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  Expanded _buildBody () {
    return Expanded(
        child: ListView.separated(
          itemCount: this.vData.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.purple[900]!.withOpacity(0.5),
          ),
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: this.vData[index]
            );},
        )
    );
  }

  Widget _buildListTile( {
    required Map dataItem
  }) {
    return ListTile(
      title: Text( dataItem[ProductKey.name],
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      leading: PrefixProduct(url: dataItem[ProductKey.url].toString()), //ListTileLeadingWidget(netWorkURL: dataItem[ProductKey.url],),
      subtitle: Text(
        dataItem[ProductKey.remark].toString(),
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontDefault, color: primaryColor),
      ),
      trailing: Column(
        children: <Widget>[
          _offsetPopup(dataItem),
        ],
      ),
    );
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
    icon: FaIcon(FontAwesomeIcons.ellipsisV,size: 20,color: ColorsUtils.iConColor()),
    offset: Offset(0, 45),
    onSelected: (value) {
      if(value == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProductScreen(vData: item)),
        );
      } else if (value == 1) {
        _showDialog(item);
      }
    },
  );

  void _showDialog(Map item) {
    ShowDialogUtil.showDialogYesNo(
        buildContext: context,
        title: Text(item[ProductKey.name]),
        content: Text('category.message.doYouWantToDeleteProduct'.tr(args: [item[ProductKey.name]])),
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
    final data = await rootBundle.loadString('assets/json_data/product_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['products'];
    });
    return this.vData;
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    return Future<bool>.value(true);
  }

}
