import 'package:flutter/material.dart';
import 'package:sale_management/screens/vendor/widgets/add_new_vendor_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class AddNewVendorScreen extends StatefulWidget {
  const AddNewVendorScreen({Key? key}) : super(key: key);

  @override
  _AddNewVendorScreenState createState() => _AddNewVendorScreenState();
}

class _AddNewVendorScreenState extends State<AddNewVendorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        elevation: DefaultStatic.elevationAppBar,
        title: Text('vendor.label.vendor'.tr()),
      ),
      body: SafeArea(
        child: AddNewVendorBody(),
      ),
    );
  }
}
