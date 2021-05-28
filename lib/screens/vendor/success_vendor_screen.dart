import 'package:flutter/material.dart';
import 'package:sale_management/screens/vendor/vendor_screen.dart';
import 'package:sale_management/screens/vendor/widgets/success_vendor_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class SuccessVendorScreen extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;
  const SuccessVendorScreen({Key? key, this.isAddScreen, this.isEditScreen, required this.vData}) : super(key: key);


  @override
  _SuccessVendorScreenState createState() => _SuccessVendorScreenState();
}

class _SuccessVendorScreenState extends State<SuccessVendorScreen> {
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
        body: SuccessVendorBody(vData: widget.vData,isAddScreen: widget.isAddScreen,isEditScreen: widget.isEditScreen,),
      ),
    );
  }


  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VendorScreen()),
    );
    return Future<bool>.value(true);
  }
}

