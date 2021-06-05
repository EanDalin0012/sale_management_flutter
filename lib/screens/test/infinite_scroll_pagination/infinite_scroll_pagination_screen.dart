import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/infinite_scroll_loading/infinite_scroll_loading.dart';

class CharacterListViewScreen extends StatefulWidget {
  const CharacterListViewScreen({Key? key}) : super(key: key);

  @override
  _CharacterListViewScreenState createState() => _CharacterListViewScreenState();
}

class _CharacterListViewScreenState extends State<CharacterListViewScreen> {
  var _pageSize = 20;
  var isLoading = false;

  ScrollController _scrollController = ScrollController();
  List<dynamic> vData = [];
  @override
  void initState() {
    _fetchItems();
    _scrollController.addListener(() async {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if(maxScroll - currentScroll <= delta) {
        this._pageSize += 1;
        setState(() {
          this.isLoading = true;
        });

        _fetchItems1().then((value) {
          print('vData.length : '+this.vData.length.toString());

          setState(() {
            this.vData = [...vData, ...value];
            this.isLoading = false;
            print('vData + vData  : '+this.vData.length.toString());
          });


        });
        print('page size : ' + this._pageSize.toString());

        // setState(() {
        //   final data = _fetchItems();
        //   this.vData = [...vData, ...data];
        //
        // });
        // this.isLoading = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('start');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        elevation: DefaultStatic.elevationAppBar,
        title: Text('category.label.category'.tr()),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _body(),
            this.isLoading ==true ? InfiniteScrollLoading(): Container(),
          ],
        ),


      ),
    );
  }
  Widget _body() => Expanded(
    child: ListView.builder(
          itemCount: this.vData.length,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return _buildListTile(dataItem: this.vData[index]);
          }),
  );
  Widget _buildListTile( {
    required Map dataItem
  }) {
    return ListTile(
      title: Text( dataItem[PackageProductKey.name],
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      // leading: _buildLeading(dataItem[PackageProductKey.productId]),
      subtitle: Text(
        FormatNumberUtils.usdFormat2Digit(dataItem[PackageProductKey.price].toString()).toString()+' \$,'+dataItem[PackageProductKey.remark].toString(),
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
                      dataItem[PackageProductKey.quantity].toString(),
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

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    this._scrollController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> _fetchItems1() async {
    await Future.delayed(Duration(seconds: 5));
    final data = await rootBundle.loadString('assets/json_data/package_of_product_list.json');
    Map mapItems = jsonDecode(data);
    List<dynamic> vData = mapItems['packageProducts'];
    return Future.value(vData);
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/package_of_product_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['packageProducts'];
    });
    return this.vData;
  }
}
