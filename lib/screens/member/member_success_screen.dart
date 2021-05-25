import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/widgets/category_success_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/screens/member/widgets/member_success_body.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class MemberSuccessScreen extends StatelessWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;

  MemberSuccessScreen({
    Key? key,
    this.isAddScreen,
    this.isEditScreen,
    required this.vData
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        leading: SizedBox(),
        title: Text('common.label.success'.tr()),
      ),
      body: MemberSuccessBody(vData: this.vData,isAddScreen: this.isAddScreen,isEditScreen: this.isEditScreen,),
    );
  }
}
