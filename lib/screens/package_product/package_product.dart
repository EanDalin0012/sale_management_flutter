import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/package_product/add_new_package_product_screen.dart';
import 'package:sale_management/screens/package_product/edit_package_product_screen.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/constants/text_style.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/model/key/product_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/utils/show_dialog_util.dart';
import 'package:sale_management/shares/widgets/app_bar_actions/appBarActions.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/floating_action_button/floating_action_button.dart';
import 'package:sale_management/shares/widgets/infinite_scroll_loading/infinite_scroll_loading.dart';
import 'package:sale_management/shares/widgets/over_list_item/over_list_item.dart';
import 'package:sale_management/shares/widgets/prefix_product/prefix_product.dart';
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
  var isLoading = false;
  var _pageSize = 20;
  late Size size;

  List<dynamic> vData = [];
  List<dynamic> vDataTmp = [];
  List<dynamic> productItems = [];
  late Map product = {};
  ScrollController _scrollController = new ScrollController();
  int vScrollInt = 0;

  @override
  void initState() {
    super.initState();
    this._fetchProductItems();
    this._fetchItems();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery
          .of(context)
          .size
          .height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        this._pageSize += 1;
        setState(() {
          this.isLoading = true;
        });
        this._fetchItemsByPageSize().then((value) {
          setState(() {
            this.vData = [...vData, ...value];
            this.isLoading = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            child: this.vData.length > 0 ? GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
              },
              child: Column(
                children: <Widget>[
                  OverListItem(
                    text: 'packageProduct.label.packageProductList'.tr(),
                    length: this.vData.length,
                  ),
                  _buildBody(),
                  this.isLoading == true ? InfiniteScrollLoading() : Container(
                    color: Colors.transparent,
                    height: 60,
                  )
                ],
              ),
            ) : CircularProgressLoading(),
          ),
          floatingActionButton: WidgetFloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewPackageProductScreen()),
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
      title: Text('packageProduct.label.packageProduct'.tr()),
      leading: IconButton(
        icon: FaIcon(
            FontAwesomeIcons.arrowLeft, color: Colors.white, size: 19
        ),
        onPressed: () {
          KeyboardUtil.hideKeyboard(context);
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
              width: size.width - 70,
              height: 65,
              margin: EdgeInsets.only(left: 18),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'search.label.searchName'.tr(),
                text: 'search.label.search'.tr(),
                onChanged: (String value) {},
              ),
            ),
            _buildFilterByProduct()
          ],
        ),
      ) : null,
    );
  }

  Widget _buildBody() {
    return Expanded(
        child: ListView.separated(
            controller: this._scrollController,
            itemCount: this.vData.length,
            separatorBuilder: (context, index) =>
                Divider(
                  color: Colors.purple[900]!.withOpacity(0.5),
                ),
            itemBuilder: (context, index) {
              if (index == vData.length) {
                return CircularProgressIndicator();
              } else {
                return _buildListTile(
                    dataItem: this.vData[index]
                );
              }
            }

        )
    );
  }

  Widget _buildListTile({
    required Map dataItem
  }) {
    return ListTile(
      title: Text(dataItem[PackageProductKey.name],
        style: TextStyle(color: ColorsUtils.isDarkModeColor(),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: fontDefault),
      ),
      leading: _buildLeading(dataItem[PackageProductKey.productId]),
      subtitle: Text(
        FormatNumberUtils.usdFormat2Digit(
            dataItem[PackageProductKey.price].toString()).toString() + ' \$,' +
            dataItem[PackageProductKey.remark].toString(),
        style: TextStyle(fontSize: 12,
            fontWeight: FontWeight.w700,
            fontFamily: fontDefault,
            color: primaryColor),
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
                        color: ColorsUtils.isDarkModeColor(),
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
                _offsetPopup(dataItem),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildLeading(int productId) {
    var url = _searchProductById(productId);
    return PrefixProduct(url: url);
  }

  Widget _buildFilterByProduct() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 12),
      child: IconButton(
        icon: FaIcon(FontAwesomeIcons.filter, size: 25, color: Colors.white),
        tooltip: 'Increase volume by 10',
        onPressed: () async {
          final product = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                ProductDropdownPage(
                  vData: this.product,
                )),
          );

          if (product == null) return;
          setState(() {
            this.product = product;
            this.vData = this._doFilterByProduct(this.product);
          });
        },
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
                  FaIcon(
                      FontAwesomeIcons.edit,
                      size: 20,
                      color: ColorsUtils.isDarkModeColor()
                  ),
                  SizedBox(width: 10,),
                  Text('common.label.edit'.tr(),
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
                      color: ColorsUtils.isDarkModeColor()),
                  SizedBox(width: 10,),
                  Text('common.label.delete'.tr(),
                    style: menuStyle,
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
        offset: Offset(0, 45),
        color: ColorsUtils.offsetPopup(),
        onSelected: (value) {
          if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  EditPackageProductScreen(vData: item)
              ),
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
        content: Text('packageProduct.message.doYouWantDeletePackageProduct'.tr(
            args: [item[PackageProductKey.name]]), style: TextStyle(color: ColorsUtils.isDarkModeColor())),
        onPressedYes: () {
          print('onPressedBntRight');
        },
        onPressedNo: () {
          print('onPressedBntLeft');
        }
    );
  }

  String _searchProductById(int productId) {
    if (this.productItems.length > 0) {
      for (Map p in productItems) {
        if (int.parse(p[ProductKey.id].toString()) == productId) {
          return p[ProductKey.url];
        }
      }
    }
    return DefaultStatic.url;
  }

  _doFilterByProduct(Map product) {
    var dataItems = vDataTmp.where((e) =>
        (e[ProductKey.id]).toString().contains(
            product[ProductKey.id].toString())
    ).toList();
    return dataItems;
  }

  _fetchProductItems() async {
    final data = await rootBundle.loadString(
        'assets/json_data/product_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.productItems = mapItems['products'];
    });
    return this.productItems;
  }

  _fetchItems() async {
    final data = await rootBundle.loadString(
        'assets/json_data/package_of_product_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['packageProducts'];
      this.vDataTmp = this.vData;
    });
    return this.vData;
  }

  Future<List<dynamic>> _fetchItemsByPageSize() async {
    await Future.delayed(Duration(seconds: 5));
    final data = await rootBundle.loadString(
        'assets/json_data/package_of_product_list.json');
    Map mapItems = jsonDecode(data);
    List<dynamic> _vData = mapItems['packageProducts'];
    return Future.value(_vData);
  }

  void vScroll() {
    this.vData = [...vData, vData[this.vScrollInt]];
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(selectIndex: 0)),
    );
    return Future<bool>.value(true);
  }

}
