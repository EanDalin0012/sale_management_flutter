import 'package:flutter/material.dart';
import 'package:sale_management/screens/member/widgets/edit_member_body.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class EditMemberScreen extends StatefulWidget {
  final Map vData;
  const EditMemberScreen({Key? key, required this.vData}) : super(key: key);

  @override
  _EditMemberScreenState createState() => _EditMemberScreenState();
}

class _EditMemberScreenState extends State<EditMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        title: Text('member.label.member'.tr()),
      ),
      body: SafeArea(
        child: EditMemberBody(vData: widget.vData),
      ),
    );
  }
}
