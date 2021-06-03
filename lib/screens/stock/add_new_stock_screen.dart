import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/stock/widgets/add_new_stock_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class AddNewStockScreen extends StatefulWidget {
  const AddNewStockScreen({Key? key}) : super(key: key);

  @override
  _AddNewStockScreenState createState() => _AddNewStockScreenState();
}

class _AddNewStockScreenState extends State<AddNewStockScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> onBackPress(),
      child: LoadingOverlay(
        isLoading: _isLoading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
          backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
          appBar: AppBar(
            backgroundColor: ColorsUtils.appBarBackGround(),
            elevation: DefaultStatic.elevationAppBar,
            title: Text('stock.label.stock'.tr()),
          ),
          body: SafeArea(
            child: AddNewStockBody(
              onChanged: (bol) {
                setState(() {
                  this._isLoading = true;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPress() {
    if(this._isLoading == true) {
      return Future<bool>.value(false);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
    return Future<bool>.value(true);
  }

}
