import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sale_management/screens/product/widgets/edit_product_body.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/utils/colors_util.dart';
import 'package:sale_management/shares/utils/toast_util.dart';

class EditProductScreen extends StatefulWidget {
  final Map vData;

  const EditProductScreen({Key? key, required this.vData}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var loading = false;
  late FToast fToast;


  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        backgroundColor: ColorsUtils.scaffoldBackgroundColor(),
        appBar: AppBar(
          backgroundColor: ColorsUtils.appBarBackGround(),
          elevation: DefaultStatic.elevationAppBar,
          title: Text('product.label.product'.tr()),
        ),
        body: SafeArea(
          child: EditProductBody(
              vData: widget.vData,
            onChanged: (value) {
              setState(() {
                this.loading = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPress() {
    if(loading == true) {
      ToastUtils.showToast(context: 'common.label.isLoadingCanNotBack'.tr(), fToast: fToast, duration: 2);
      return Future<bool>.value(false);
    } else {
      return Future<bool>.value(true);
    }

  }
}
