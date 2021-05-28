import 'package:flutter/material.dart';
import 'package:sale_management/screens/product/product_screen.dart';
import 'package:sale_management/screens/product/widgets/product_success_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductSuccessScreen extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;

  ProductSuccessScreen({
    Key? key,
    this.isAddScreen,
    this.isEditScreen,
    required this.vData
  }):super(key: key);

  @override
  _ProductSuccessScreenState createState() => _ProductSuccessScreenState();
}

class _ProductSuccessScreenState extends State<ProductSuccessScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ColorsUtils.appBarBackGround(),
          elevation: DefaultStatic.elevationAppBar,
          leading: SizedBox(),
          title: Text('common.label.success'.tr()),
        ),
        body: ProductSuccessBody(vData: widget.vData,isAddScreen: widget.isAddScreen,isEditScreen: widget.isEditScreen,),
      ),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen()),
    );
    return Future<bool>.value(true);
  }
}
