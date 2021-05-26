import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/category_screen.dart';
import 'package:sale_management/screens/category/widgets/category_success_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class CategorySuccessScreen extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;
  const CategorySuccessScreen({Key? key, this.isAddScreen, this.isEditScreen, required this.vData}) : super(key: key);

  @override
  _CategorySuccessScreenState createState() => _CategorySuccessScreenState();
}

class _CategorySuccessScreenState extends State<CategorySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        leading: SizedBox(),
        title: Text('common.label.success'.tr()),
      ),
      body: CategorySuccessBody(vData: widget.vData,isAddScreen: widget.isAddScreen,isEditScreen: widget.isEditScreen,),
    );
  }

  Future<bool> onBackPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen()),
    );
    return Future<bool>.value(true);
  }

}
