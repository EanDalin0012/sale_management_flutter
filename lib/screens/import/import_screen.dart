import 'package:flutter/material.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/import/widgets/import_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/search_widget/search_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/two_tab/two_tab.dart';
import 'add_new_import_screen.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({Key? key}) : super(key: key);

  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {

  var isNative = false;
  late Size size ;
  List<dynamic> vData = [];
  var vDataLength = 0;
  var selectedProduct = true;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop:  () => onBackPress(),
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
                    children: <Widget>[// 4%
                      Text("Import Product", style: TextStyleUtils.headingStyle()),
                      this.selectedProduct ? Center(
                        child: Text(
                          "All Product Import.",
                          textAlign: TextAlign.center,
                        ),
                      ) :
                      Center(
                        child: Text(
                          "All Transaction Import.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                TwoTabs(
                  textTab0: 'Product',
                  textTab1: "Transaction",
                  onChanged: (tabIndex) {
                    setState(() {
                      if(tabIndex == 0) {
                        this.selectedProduct = true;
                      }else if (tabIndex == 1) {
                        this.selectedProduct = false;
                      }
                    });
                  },
                ),
                Expanded(
                  child: ImportBody(filterByProduct: this.selectedProduct),
                ),
              // OverListItem(
              //     text: 'import.label.importList'.tr(),
              //     length: this.vData.length,
              // ),
              //this.vData.length > 0 ? _buildBody() : CircularProgressLoading()
            ],
          ),
          ),
        ),
        floatingActionButton: _floatingActionButton()
      ),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      elevation: DefaultStatic.elevationAppBar,
      title: Text('import.label.import'.tr()),
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
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: SearchWidget(
                hintText: 'search.label.searchName'.tr(),
                text: 'search.label.searchName'.tr(),
                onChanged: (value) {
                },
              ),
            ),
            // _buildFilterByCategory()
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
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    return Future<bool>.value(true);
  }
}
