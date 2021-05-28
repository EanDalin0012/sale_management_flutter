import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sale_management/screens/package_product/widgets/edit_package_product_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class EditPackageProductScreen extends StatefulWidget {
  final Map vData;
  const EditPackageProductScreen({Key? key, required this.vData}) : super(key: key);

  @override
  _EditPackageProductState createState() => _EditPackageProductState();
}

class _EditPackageProductState extends State<EditPackageProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        elevation: DefaultStatic.elevationAppBar,
        title: Text('packageProduct.label.packageProduct'.tr()),
      ),
      body: SafeArea(
        child: EditPackageProductBody(vData: widget.vData),
      ),
    );
  }
}
