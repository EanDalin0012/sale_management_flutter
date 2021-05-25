import 'package:flutter/material.dart';
import 'package:sale_management/screens/vendor/widgets/success_vendor_body.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class SuccessVendorScreen extends StatelessWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;
  const SuccessVendorScreen({Key? key, this.isAddScreen, this.isEditScreen, required this.vData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        leading: SizedBox(),
        title: Text('common.label.success'.tr()),
      ),
      body: SuccessVendorBody(vData: this.vData,isAddScreen: this.isAddScreen,isEditScreen: this.isEditScreen,),
    );
  }
}
