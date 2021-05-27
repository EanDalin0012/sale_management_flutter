import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/icon_check/icon_check.dart';
import 'package:sale_management/shares/widgets/prefix_product/prefix_product.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class PackageProductDropdownPage extends StatefulWidget {
  final Map packageProduct;
  final Map product;
  const PackageProductDropdownPage({
    Key? key,
    required this.packageProduct,
    required this.product
  }) : super(key: key);

  @override
  _PackageProductDropdownPageState createState() => _PackageProductDropdownPageState();
}

class _PackageProductDropdownPageState extends State<PackageProductDropdownPage> {

  var controller = TextEditingController();
  var isItemChanged = false;
  var isFilterByProduct = false;
  var isNative = false;
  var isSearch = false;
  var text = '';
  late Size size ;
  var styleInput;
  var menuStyle;
  List<dynamic> items = [];
  List<dynamic> itemsTmp = [];
  List<dynamic> productItems = [];
  List<dynamic> vProductData = [];
  List<dynamic> vProductDataTmp = [];
  var url =  DefaultStatic.url;
  @override
  void initState() {
    this._fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    styleInput = TextStyle(color: ColorsUtils.isDarkModeColor(), fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontDefault);
    menuStyle = TextStyle( color: Colors.purple[900], fontWeight: FontWeight.w500, fontFamily: fontDefault);
    if(widget.product[ProductKey.url].toString() != 'null') {
      this.url = widget.product[ProductKey.url].toString();
    }

    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: _buildAppBar(),
      body: InkWell(
        onTap: () {
          KeyboardUtil.hideKeyboard(context);
        },
        child: Column(
          children: <Widget>[
            if (this.items.length > 0 ) _buildBody() else CircularProgressLoading(),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      title: Text('packageProduct.label.packageSelectProduct'.tr()),
      actions: [
        IconButton(
          icon: Icon(this.isNative ? Icons.close : Icons.search),
          onPressed: () => setState(() {
            if(this.isNative == true) {
              this.items = this.itemsTmp;
            }
            this.isNative = !isNative;
            this.isItemChanged = false;
            this.isFilterByProduct = false;
          }),
        ),
        const SizedBox(width: 8),
      ],
      bottom: this.isNative ? PreferredSize(preferredSize: Size.fromHeight(60),
        child: Container(
          width: size.width - 40,
          height: 65,
          margin: EdgeInsets.only(left: 18),
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: SearchWidget(
            hintText: 'search.label.searchName'.tr(),
            text: 'search.label.searchName'.tr(),
            onChanged: (value) {
              setState(() {
                items = onItemChanged(value);
              });
            },
          ),
        ),
      ): null,
    );
  }

  Widget _buildBody () {
    return Expanded(
        child:  ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildListTile(
                dataItem: this.items[index]
            );
          },
        )
    );
  }


  Widget _buildListTile({
    required Map dataItem
  }) {
    return ListTile(
      onTap: () => selectPackageProduct(dataItem),
      title: Text( '${dataItem[PackageProductKey.name]}',
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      leading: PrefixProduct(url: this.url),
      subtitle: Text(
        FormatNumber.usdFormat2Digit(dataItem[PackageProductKey.price].toString()).toString()+' \$,'+dataItem[PackageProductKey.remark],
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
            if (widget.packageProduct.toString() != '{}' && dataItem[PackageProductKey.id] == widget.packageProduct[PackageProductKey.id])
              Center(child: IconCheck()) else Container()
          ],
        ),
      ),
    );
  }

  onItemChanged(String value) {
    var dataItems = itemsTmp.where((e) => e[PackageProductKey.name].toLowerCase().contains(value.toLowerCase())).toList();
    return dataItems;
  }

  void selectPackageProduct(Map packageProductModel) {
    Navigator.pop(context, packageProductModel);
  }

  _fetchItems() async {
    final data = await rootBundle.loadString(
        'assets/json_data/package_of_product_list.json');
    Map valueMap = jsonDecode(data);
    var dataItems = valueMap['packageProducts'];
    var items = dataItems.where((e) => e[PackageProductKey.productId].toString().contains(widget.product[ProductKey.id].toString())).toList();
    setState(() {
      this.items = items;
      this.itemsTmp = this.items;
    });
    return this.items;
  }


}
