import 'package:flutter/material.dart';
import 'package:sale_management/screens/category/category_screen.dart';
import 'package:sale_management/screens/package_product/package_product.dart';
import 'package:sale_management/shares/constants/text_style.dart';
import 'package:sale_management/shares/model/key/package_product_key.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/default_button/default_button.dart';
import 'package:easy_localization/easy_localization.dart';

class PackageProductSuccessBody extends StatelessWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;
  PackageProductSuccessBody({Key? key,this.isEditScreen, this.isAddScreen, required this.vData}): super(key: key);

  GlobalKey<NavigatorState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async {
        if (_key.currentState!.canPop()) {
          _key.currentState!.pop();
          return false;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryScreen()),
        );
        return true;

      },
      child: Column(
        children: <Widget>[
          SizedBox(height: SizeConfig.screenHeight * 0.07),
          Center(
            child: Image.asset(
              "assets/icons/success-green-check-mark.png",
              height: SizeConfig.screenHeight * 0.2, //40%
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.07),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                if (this.isAddScreen == true)
                  Text('packageProduct.label.registerPackageProduct'.tr(), style: TextStyleUtils.headingStyle()),
                if(this.isEditScreen == true)
                  Text('packageProduct.label.updatePackageProduct'.tr(), style: TextStyleUtils.headingStyle()),

                Text('common.label.isCompleted'.tr(args: [this.vData[PackageProductKey.name]]),textAlign: TextAlign.center,),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Center(
            child: Text(
              'common.label.success'.tr(),
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.7,
            child: DefaultButton(
              elevation: 3,
              text: 'common.label.back'.tr(),
              color: Colors.green[800],
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PackageProductScreen()),
                );

              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
