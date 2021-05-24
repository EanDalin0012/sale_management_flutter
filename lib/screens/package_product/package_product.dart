import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/over_list_item/over_list_item.dart';
import 'package:sale_management/shares/widgets/product_dropdown/product_dropdown.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';

class PackageProductScreen extends StatefulWidget {
  const PackageProductScreen({Key? key}) : super(key: key);

  @override
  _PackageProductScreenState createState() => _PackageProductScreenState();
}

class _PackageProductScreenState extends State<PackageProductScreen> {
  var isNative = false;
  bool isSearch = false;
  late Size size ;
  List<dynamic> vData = [];
  List<dynamic> vDataTmp = [];
  List<dynamic> productItems = [];
  late Map product = {};

  @override
  void initState() {
    super.initState();
    this._fetchProductItems();
    this._fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: _buildAppBar(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              OverListItem(
                text: 'packageProduct.label.packageProductList'.tr(),
                length: this.vData.length,
              ),
              this.vData.length > 0 ? _buildBody() : CircularProgressLoading()
            ],
          ),
        ),
      floatingActionButton: _floatingActionButton()
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      title: Text('packageProduct.label.packageProduct'.tr()),
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
              width: size.width - 70,
              height: 65,
              margin: EdgeInsets.only(left: 18),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'search.label.searchName'.tr(),
                text: 'search.label.search'.tr(),
                onChanged: (String value) {  },
              ),
            ),
            _buildFilterByProduct()
          ],
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
            );},
        )
    );
  }

  Widget _buildListTile( {
    required Map dataItem
  }) {
    return ListTile(
      title: Text( dataItem[PackageProductKey.name],
        style: TextStyle( color: ColorsUtils.isDarkModeColor(), fontSize: 20, fontWeight: FontWeight.w700,fontFamily: fontDefault),
      ),
      leading: _buildLeading(dataItem[PackageProductKey.productId]),
      subtitle: Text(
        FormatNumber.usdFormat2Digit(dataItem[PackageProductKey.price].toString()).toString()+' \$,'+dataItem[PackageProductKey.remark].toString(),
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

  Widget _buildLeading(int productId) {
    var url = _searchProductById(productId);
    if(url == null) {
      url = 'https://icons-for-free.com/iconfiles/png/512/part+1+p-1320568343314317876.png';
    }
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

  Widget _buildFilterByProduct() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 12),
      child: IconButton(
        icon: FaIcon(FontAwesomeIcons.filter,size: 25 , color: ColorsUtils.iConColor(),),
        tooltip: 'Increase volume by 10',
        onPressed: () async {
          final product = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductDropdownPage(
              vData: this.product,
            )),
          );

          if (product == null) return;
          setState(() {
            this.product = product;
            this.vData = this._doFilterByProduct(this.product);
            print('this.vData'+ this.vData.toString());
          });
        },
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: (){
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => AddNewCategoryScreen()),
        // );
      },
      tooltip: 'category.label.addNewCategory'.tr(),
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  String _searchProductById(int productId) {
    if(this.productItems.length > 0) {
      for(Map p in productItems) {
        if(int.parse(p[ProductKey.id].toString()) == productId) {
          return p[ProductKey.url];
        }
      }
    }
    return "";
  }

  _doFilterByProduct(Map product) {
    print('_doFilterByProduct'+product.toString());
    var dataItems = vDataTmp.where((e) => (e[ProductKey.id]).toString().contains(product[ProductKey.id].toString())
    ).toList();
    return dataItems;
  }

  _fetchProductItems() async {
    final data = await rootBundle.loadString('assets/json_data/product_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.productItems = mapItems['products'];
    });
    return this.productItems;
  }

  _fetchItems() async {
    final data = await rootBundle.loadString('assets/json_data/package_of_product_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['packageProducts'];
      this.vDataTmp = this.vData;
    });
    return this.vData;
  }

}
