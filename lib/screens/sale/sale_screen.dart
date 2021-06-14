import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/sale/widgets/sale_details.dart';
import 'package:sale_management/shares/model/key/sale_key.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/format_date.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/infinite_scroll_loading/infinite_scroll_loading.dart';
import 'package:sale_management/shares/widgets/over_list_item/over_list_item.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';
import 'package:share/share.dart';
import 'add_new_sale_screen.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);

  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  var isNative = false;
  late Size size;

  List<dynamic> vData = [];
  ScrollController _scrollController = new ScrollController();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    this._fetchItems();
    this._scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery
          .of(context)
          .size
          .height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        setState(() {
          this.isLoading = true;
        });
        this._fetchItemsByPageSize().then((value) {
          if (value.length > 0) {
            setState(() {
              this.vData = [...vData, ...value];
              this.isLoading = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
        appBar: _buildAppBar(),
        floatingActionButton: _floatingActionButton(),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(children: <Widget>[
              this.vData.length > 0 ? _buildBody() : CircularProgressLoading(),
              this.isLoading == true ? InfiniteScrollLoading() : Container(
                color: Colors.transparent,
                height: 60,
              )
            ]),
          ),

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
                      text: FormatDateUtils.dateFormat(
                          yyyyMMdd: e[SaleKey.transactionDate].toString()),
                      length: mData.length,
                    ),
                    Column(
                      children: mData.map((item) {
                        i += 1;
                        return _buildCard(dataItem: item, transactionDate: e[SaleKey.transactionDate].toString());
                      }).toList(),
                    ),
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
      elevation: 0,
      title: Text('sale.label.sale'.tr()),
      leading: SizedBox(),
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
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'search.label.searchName'.tr(),
                text: 'search.label.searchName'.tr(),
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ) : null,
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: ColorsUtils.floatingActionButton(),
      onPressed: () {
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

  Widget _buildCard({required Map dataItem, required String transactionDate}) {
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
      child: Column(
        children: <Widget>[
          Container(
            height: 178,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF22293D),
              borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('sale.label.sell'.tr()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('sale.label.customerName'.tr()) + ' :'),
                      Text(dataItem[SaleKey.customerName].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('sale.label.phone'.tr()) + ' :'),
                      Text(dataItem[SaleKey.phoneNumber].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('sale.label.amount'.tr()) + ' :'),
                      Text( FormatNumberUtils.usdFormat2Digit(dataItem[SaleKey.total].toString()).toString() + ' USD'),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('sale.label.transID'.tr()) + ' :'),
                      Text(dataItem[SaleKey.transactionId].toString()),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(('common.label.remark'.tr()) + ' :'),
                      Text(dataItem[SaleKey.remark].toString()),
                    ],
                  ),
                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text( FormatDateUtils.dateTime(hhnn: transactionDate.substring(8,12))),
                      Container(
                        //color: Colors.red,
                        width: 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Map json = {
                                  SaleKey.phoneNumber: dataItem[SaleKey.phoneNumber],
                                  SaleKey.customerName: dataItem[SaleKey.customerName],
                                  SaleKey.transactionId: dataItem[SaleKey.transactionId],
                                  SaleKey.transactionDate: transactionDate + ' ' +FormatDateUtils.dateTime(hhnn: transactionDate.substring(8,12)),
                                  SaleKey.time: transactionDate.substring(8,12),
                                  SaleKey.total: FormatNumberUtils.usdFormat2Digit(
                                      dataItem[SaleKey.total].toString()).toString()
                                };

                                _showModelSheet(json);
                              },
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Color(0xff6E747F),
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Center(child: FaIcon(FontAwesomeIcons.infoCircle, size: 15, color: Colors.white,))
                              ),
                            ),
                            Builder(builder: (BuildContext context) {
                              return InkWell(
                                onTap: () {
                                  Share.share(
                                      'Sell'+"\n"
                                      +'Customer Name : ${dataItem[SaleKey.customerName].toString()}'+"\n"
                                      +'Phone Number : ${dataItem[SaleKey.phoneNumber].toString()}'+"\n"
                                      +'Amount : ${FormatNumberUtils.usdFormat2Digit(dataItem[SaleKey.total].toString()).toString() + ' USD'}'+"\n"
                                      +'Trans ID : ${dataItem[SaleKey.transactionId].toString()}'+"\n"
                                      +'Time : ${FormatDateUtils.dateTime(hhnn: transactionDate.substring(8,12))}'+"\n"
                                      +'Remark : ${dataItem[SaleKey.remark].toString()}'+"\n",
                                      subject: 'Look what I made!'
                                  );
                                },
                                child: Container(
                                    height: 25,
                                    width: 25,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Color(0xff6E747F),
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Center(child: FaIcon(FontAwesomeIcons.shareAltSquare, size: 15, color: Colors.white,))),
                              );
                            }),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(selectIndex: 0)),
    );
    return Future<bool>.value(true);
  }

  _showModelSheet(Map item) {
    var orientation = MediaQuery
        .of(context)
        .orientation;
    double height = (MediaQuery
        .of(context)
        .copyWith()
        .size
        .height * 0.9);
    setState(() {
      if (orientation != Orientation.portrait) {
        height = MediaQuery
            .of(context)
            .copyWith()
            .size
            .height * 0.5;
      }
    });

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.9,
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
    final data = await rootBundle.loadString(
        'assets/json_data/sale_transaction_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vData = mapItems['transactionList'];
      this.vData = [...vData, ...vData];
    });
    return this.vData;
  }

  Future<List<dynamic>> _fetchItemsByPageSize() async {
    await Future.delayed(Duration(seconds: 5));
    final data = await rootBundle.loadString(
        'assets/json_data/sale_transaction_list.json');
    Map mapItems = jsonDecode(data);

    List<dynamic> _vData = mapItems['transactionList'];
    return Future.value(_vData);
  }

}
