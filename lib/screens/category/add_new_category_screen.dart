import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/widgets/add_new_category_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({Key? key}) : super(key: key);

  @override
  _AddNewCategoryScreenState createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        elevation: DefaultStatic.elevationAppBar,
        title: Text('category.label.category'.tr()),
      ),
      body: SafeArea(
        child: AddBewCategoryBody(),
      ),
    );
  }
}
