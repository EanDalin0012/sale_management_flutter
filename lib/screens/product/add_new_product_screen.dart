import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/screens/product/widgets/add_new_product_body.dart';
import 'package:sale_management/shares/utils/widgets_util.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsUtil.appBar(title: 'product.label.product'.tr()),
      body: SafeArea(
        child: AddNewProductBody(),
      ),
    );
  }
}
