import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/shares/constants/color.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/m_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/format_date.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/utils/number_format.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/circular_progress_indicator/circular_progress_indicator.dart';
import 'package:sale_management/shares/widgets/infinite_scroll_loading/infinite_scroll_loading.dart';
import 'package:sale_management/shares/widgets/over_list_item/over_list_item.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'add_new_import_screen.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({Key? key}) : super(key: key);

  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  late FToast fToast;
  var isLoading = false;
  var isNative = false;
  late Size size;

  List<dynamic> vData = [];
  var vDataLength = 0;
  var selectedProduct = true;
  ScrollController _scrollController = new ScrollController();
  List<dynamic> vDataAll = [];


  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _fetchAllItems();
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
        _fetchAllItemsByPageSize().then((value) {
          if (value.length > 0) {
            setState(() {
              this.vDataAll = [...vDataAll, ...value];
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
          body: SafeArea(
            child: InkWell(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
              },
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Center(
                    child: Column(
                      children: <Widget>[ // 4%
                        Text('import.label.importProduct'.tr(),
                            style: TextStyleUtils.headingStyle()),
                        Center(
                          child: Text(
                            'import.label.allTransactionImport'.tr(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  this.vDataAll.length > 0 ? Expanded(
                    child: _buildBody(),
                  ) : CircularProgressLoading(),
                ],
              ),
            ),
          ),
          floatingActionButton: _floatingActionButton()
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      elevation: DefaultStatic.elevationAppBar,
      title: Text('import.label.import'.tr()),
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
            // _buildFilterByCategory()
            // _buildFilterByProduct()
          ],
        ),
      ) : null,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          _buildAllTransaction(),
          this.isLoading == true ? InfiniteScrollLoading() : Container(
            color: Colors.transparent,
            height: 60,
          )
        ],
      ),
    );
  }


  Widget _buildAllTransaction() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: this.vDataAll.map((e) {
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
                    yyyyMMdd: e[ImportKey.transactionDate].toString()),
                length: mData.length,
              ),
              Column(
                children: mData.map((item) {
                  i += 1;
                  return Container(
                    decoration: mDataLength != i ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color(0xCD939BA9).withOpacity(0.2),
                              width: 1.5),
                        )
                    ) : null,
                    child: _buildListTile(
                        transactionId: item[ImportKey.transactionId].toString(),
                        transactionDate: e[ImportKey.transactionDate]
                            .toString(),
                        time: item[ImportKey.time].toString(),
                        total: item[ImportKey.total].toString()
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildListTile({
    required String transactionId,
    required String transactionDate,
    required String time,
    required String total,
  }) {
    return ListTile(
      leading: _buildLeading(),
      title: Text(
        transactionId,
        style: TextStyle(color: ColorsUtils.isDarkModeColor(),
            fontWeight: FontWeight.w500,
            fontFamily: fontDefault),
      ),
      subtitle: Text(
        FormatDateUtils.dateTime(hhnn: time),
        style: TextStyle(fontFamily: fontDefault,
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: primaryColor),
      ),
      trailing: Container(
        width: 110,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                FormatNumberUtils.usdFormat2Digit(total).toString() + ' \$',
                style: TextStyle(fontFamily: fontDefault,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorsUtils.isDarkModeColor()),
              ),
              SizedBox(width: 10,),
              FaIcon(FontAwesomeIcons.chevronRight, size: 20,
                  color: Colors.black54.withOpacity(0.5))
            ]
        ),
      ),
    );
  }

  Widget _buildLeading() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60)),
        border: Border.all(
            color: Colors.deepPurpleAccent.withOpacity(0.7), width: 2),
      ),
      child: CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.transparent,
        child: FaIcon(
            FontAwesomeIcons.receipt, size: 20, color: Colors.deepPurple),
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddNewImportScreen()),
        );
      },
      tooltip: 'product.label.addNewProduct'.tr(),
      elevation: 5,
      child: Icon(Icons.add_circle, size: 50,),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(selectIndex: 0)),
    );
    return Future<bool>.value(true);
  }

  _fetchAllItems() async {
    await Future.delayed(Duration(seconds: 1));
    final data = await rootBundle.loadString(
        'assets/json_data/import_transactions.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vDataAll = mapItems['imports'];
    });
  }

  Future<List<dynamic>> _fetchAllItemsByPageSize() async {
    await Future.delayed(Duration(seconds: 5));
    final data = await rootBundle.loadString(
        'assets/json_data/import_transactions.json');
    Map mapItems = jsonDecode(data);
    List<dynamic> mData = mapItems['imports'];
    return Future.value(mData);
  }

}
