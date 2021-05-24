import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/icon_check/icon_check.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDropdownPage extends StatefulWidget {
  final Map vData;
  const ProductDropdownPage({Key? key, required this.vData}) : super(key: key);

  @override
  _ProductDropdownPageState createState() => _ProductDropdownPageState();
}

class _ProductDropdownPageState extends State<ProductDropdownPage> {
  var isNative = false;
  var text = '';
  var controller = TextEditingController();
  var isSearch = false;
  var isItemChanged = false;
  var styleInput;

  int vDataLength = 0;
  List<dynamic> vData = [];
  List<dynamic> vDataTmp = [];

  @override
  void initState() {
    super.initState();
    this._fetchListItems();
  }

  @override
  Widget build(BuildContext context) {
    styleInput = TextStyle(color: ColorsUtils.isDarkModeColor(), fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontDefault);
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: _buildAppBar(),
      body: Column(
          children: <Widget>[
            if (this.vData.length > 0 ) _buildBody() else CircularProgressLoading(),
          ]
      ),
    );
  }

  AppBar _buildAppBar() {
    final label = 'product.label.selectProduct'.tr();

    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      title: Text('$label'),
      actions: [
        IconButton(
          icon: Icon(isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() => this.isNative = !isNative),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child:  Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: SearchWidget(
            hintText: 'search.label.searchName'.tr(),
            text: 'search.label.searchName'.tr(),
            onChanged:(value) {
              if(value.isNotEmpty) {
                setState(() {
                  this.vData = onItemChanged(value);
                  this.vDataLength = this.vData.length;
                });
              }
            },
          ),
        ),
      ): null,
    );
  }

  Widget _buildBody () {
    return Expanded(
      child: ListView.separated(
        itemCount: this.vData.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.purple[900]!.withOpacity(0.5),
        ),
        itemBuilder: (context, index) {
          return _buildListTile(
              dataItem: this.vData[index]
          );
        },
      ),
    );
  }

  Widget _buildListTile({
     required Map dataItem
  }) {
    var productName = '';
    var obj = widget.vData;
    if(obj != null) {
      productName = obj[ProductKey.name].toString().toLowerCase();
    }

    return ListTile(
      onTap: () => selectProduct(dataItem),
      title: Text('${dataItem[ProductKey.name]}',
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      leading: _buildLeading(dataItem[ProductKey.url]),
      subtitle: Text('${dataItem[ProductKey.remark]}',
        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, fontFamily: fontDefault, color: primaryColor),
      ),
      trailing: (dataItem[ProductKey.name]).toLowerCase() == productName ? IconCheck() : null,
    );
  }

  Widget _buildLeading(String url) {
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

  _fetchListItems() async {
    final data = await rootBundle.loadString('assets/json_data/product_list.json');
    Map valueMap = jsonDecode(data);
    var products = valueMap['products'];
    setState(() {
      this.vData = products;
      this.vDataTmp = this.vData;
      this.vDataLength = this.vData.length;
    });
    return vData;
  }

  void selectProduct(Map productModel) {
    Navigator.pop(context, productModel);
  }

  onItemChanged(String value) {
    var dataItems = vDataTmp.where((e) => e[ProductKey.name].toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }
}
