import 'package:flutter/material.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
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

  var isNative = false;
  late Size size ;
  List<dynamic> vData = [];
  var vDataLength = 0;

  @override
  Widget build(BuildContext context) {
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
              OverListItem(
                  text: 'import.label.importList'.tr(),
                  length: this.vData.length,
              ),
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
