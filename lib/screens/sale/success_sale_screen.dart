import 'package:flutter/material.dart';
import 'package:sale_management/screens/sale/sale_screen.dart';
import 'package:sale_management/screens/sale/widgets/success_sale_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class SuccessSaleScreen extends StatefulWidget {
  final Map vData;

  const SuccessSaleScreen({Key? key, required this.vData}) : super(key: key);

  @override
  _SuccessSaleScreenState createState() => _SuccessSaleScreenState();
}

class _SuccessSaleScreenState extends State<SuccessSaleScreen> {
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
        body: SuccessSaleBody(vData: widget.vData),
      ),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SaleScreen()),
    );
    return Future<bool>.value(true);
  }
}
