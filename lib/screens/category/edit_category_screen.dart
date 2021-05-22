import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/screens/category/widgets/edit_category_body.dart';

class EditCategoryScreen extends StatefulWidget {
  final Map vData;
  const EditCategoryScreen({Key? key, required this.vData}) : super(key: key);

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text('category.label.category'.tr()),
      ),
      body: SafeArea(
        child: EditCategoryBody(vData: widget.vData),
      ),
    );
  }
}
