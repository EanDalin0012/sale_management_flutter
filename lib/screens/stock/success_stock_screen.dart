import 'package:flutter/material.dart';
import 'package:sale_management/screens/stock/stock_screen.dart';
import 'package:sale_management/screens/stock/widgets/success_stock_body.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class SuccessStockScreen extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;

  const SuccessStockScreen({Key ?key, this.isEditScreen, required this.vData, this.isAddScreen}) : super(key: key);

  @override
  _SuccessStockScreenState createState() => _SuccessStockScreenState();
}

class _SuccessStockScreenState extends State<SuccessStockScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> onBackPress(),
      child: Scaffold(
        backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ColorsUtils.appBarBackGround(),
          leading: SizedBox(),
          title: Text('common.label.success'.tr()),
        ),
        body: SuccessStockBody(vData: widget.vData,isAddScreen: widget.isAddScreen, isEditScreen: widget.isEditScreen,),
      ),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StockScreen()),
    );
    return Future<bool>.value(true);
  }
}
