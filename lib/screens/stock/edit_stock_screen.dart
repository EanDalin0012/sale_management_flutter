import 'package:flutter/material.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/stock/widgets/edit_stock_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class EditStockScreen extends StatefulWidget {
  final Map vData;
  const EditStockScreen({Key? key, required this.vData}) : super(key: key);

  @override
  _EditStockScreenState createState() => _EditStockScreenState();
}

class _EditStockScreenState extends State<EditStockScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> onBackPress(),
      child: Scaffold(
        backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ColorsUtils.appBarBackGround(),
          elevation: DefaultStatic.elevationAppBar,
          title: Text('stock.label.stock'.tr()),
        ),
        body: SafeArea(
          child: EditStockBody(vData: widget.vData),
        ),
      )
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
