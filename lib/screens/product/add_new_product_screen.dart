import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/screens/product/widgets/add_new_product_body.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        foregroundColor: Colors.purple[900],
        title: Text('product.label.product'.tr()),
      ),
      body: SafeArea(
        child: AddNewProductBody(),
      ),
    );
  }
}
