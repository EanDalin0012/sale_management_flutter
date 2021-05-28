import 'package:flutter/material.dart';
import 'package:sale_management/screens/vendor/widgets/edit_vendor_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class EditVendorScreen extends StatefulWidget {
  final Map vData;
  const EditVendorScreen({Key? key, required this.vData}) : super(key: key);

  @override
  _EditVendorScreenState createState() => _EditVendorScreenState();
}

class _EditVendorScreenState extends State<EditVendorScreen> {
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
        child: EditVendorBody(vData: widget.vData),
      ),
    );
  }
}
