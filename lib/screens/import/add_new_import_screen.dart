import 'package:flutter/material.dart';
import 'package:sale_management/screens/import/widgets/add_new_import_body.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:easy_localization/easy_localization.dart';

class AddNewImportScreen extends StatefulWidget {
  const AddNewImportScreen({Key? key}) : super(key: key);

  @override
  _AddNewImportScreenState createState() => _AddNewImportScreenState();
}

class _AddNewImportScreenState extends State<AddNewImportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorsUtils.appBarBackGround(),
        title: Text('import.label.import'.tr()),
      ),
      body: SafeArea(
        child: AddNewImportBody(),
      ),
    );
  }
}
