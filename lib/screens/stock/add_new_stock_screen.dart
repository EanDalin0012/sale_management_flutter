import 'package:flutter/material.dart';
import 'package:sale_management/screens/home/home_screen.dart';
import 'package:sale_management/screens/stock/widgets/add_new_stock_body.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class AddNewStockScreen extends StatefulWidget {
  const AddNewStockScreen({Key? key}) : super(key: key);

  @override
  _AddNewStockScreenState createState() => _AddNewStockScreenState();
}

class _AddNewStockScreenState extends State<AddNewStockScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> onBackPress(),
      child: Scaffold(
        backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
        body: SafeArea(
          child: AddNewStockBody(),
        ),
      ),
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
