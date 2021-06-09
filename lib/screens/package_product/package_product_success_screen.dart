import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/screens/package_product/package_product.dart';
import 'package:sale_management/screens/package_product/widgets/package_product_success_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class PackageProductSuccessScreen extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;

  PackageProductSuccessScreen({
    Key? key,
    this.isAddScreen,
    this.isEditScreen,
    required this.vData
  }) :super(key: key);

  @override
  _PackageProductSuccessScreenState createState() =>
      _PackageProductSuccessScreenState();
}

class _PackageProductSuccessScreenState
    extends State<PackageProductSuccessScreen> {
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
        body: PackageProductSuccessBody(vData: widget.vData,
          isAddScreen: widget.isAddScreen,
          isEditScreen: widget.isEditScreen,),
      ),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PackageProductScreen()),
    );
    return Future<bool>.value(true);
  }
}
