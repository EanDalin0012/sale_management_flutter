import 'package:flutter/material.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class AddNewMemberScreen extends StatefulWidget {
  const AddNewMemberScreen({Key? key}) : super(key: key);

  @override
  _AddNewMemberScreenState createState() => _AddNewMemberScreenState();
}

class _AddNewMemberScreenState extends State<AddNewMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        title: Text('member.label.member'.tr()),
      ),
    );
  }
}
