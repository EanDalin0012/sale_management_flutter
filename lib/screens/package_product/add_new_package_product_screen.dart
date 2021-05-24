import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/package_product/widgets/add_new_package_product_body.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class AddNewPackageProductScreen extends StatefulWidget {
  const AddNewPackageProductScreen({Key? key}) : super(key: key);

  @override
  _AddNewPackageProductScreenState createState() => _AddNewPackageProductScreenState();
}

class _AddNewPackageProductScreenState extends State<AddNewPackageProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        title: Text('packageProduct.label.packageProduct'.tr()),
      ),
      body: SafeArea(
        child: AddNewPackageProductBody(),
      ),
    );
  }
}
