import 'package:flutter/material.dart';
import 'package:sale_management/screens/sale/widgets/confirm_sale_body.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class ConfirmSaleScreen extends StatefulWidget {
  final List<dynamic> vData;
  const ConfirmSaleScreen({Key? key, required this.vData}) : super(key: key);

  @override
  _ConfirmSaleScreenState createState() => _ConfirmSaleScreenState();
}

class _ConfirmSaleScreenState extends State<ConfirmSaleScreen> {

  List<dynamic> vData = [];

  @override
  void initState() {
    super.initState();
    this.vData = widget.vData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: _buildAppBar(),
      body: SafeArea(
          child: ConfirmSaleBody(
              vData: widget.vData,
              onChanged: (items) {
                setState(() {
                  this.vData = items;
                });
              }
          )
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsUtils.appBarBackGround(),
      title: Text('common.label.confirm'.tr(), style: TextStyle(fontFamily: fontDefault, fontWeight: FontWeight.w700)),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context, this.vData);
        },
        child: Icon(
            Icons.arrow_back
        ),
      ),
    );
  }

}
