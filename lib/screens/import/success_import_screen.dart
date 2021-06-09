import 'package:flutter/material.dart';
import 'package:sale_management/screens/import/import_screen.dart';
import 'package:sale_management/screens/import/widgets/success_import_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class SuccessImportScreen extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;

  const SuccessImportScreen(
      {Key? key, this.isAddScreen, this.isEditScreen, required this.vData})
      : super(key: key);

  @override
  _SuccessImportScreenState createState() => _SuccessImportScreenState();
}

class _SuccessImportScreenState extends State<SuccessImportScreen> {
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
        body: SafeArea(
          child: SuccessImportBody(vData: widget.vData,
              isEditScreen: widget.isEditScreen,
              isAddScreen: widget.isAddScreen),
        ),
      ),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImportScreen()),
    );
    return Future<bool>.value(true);
  }

}
