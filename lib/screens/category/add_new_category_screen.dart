import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/widgets/add_new_category_body.dart';
import 'package:easy_localization/easy_localization.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({Key? key}) : super(key: key);

  @override
  _AddNewCategoryScreenState createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text('category.label.category'.tr()),
      ),
      body: SafeArea(
        child: AddBewCategoryBody(),
      ),
    );
  }
}
