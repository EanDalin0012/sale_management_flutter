import 'package:flutter/material.dart';
import 'package:sale_management/screens/vendor/vendor_screen.dart';
import 'package:sale_management/shares/model/key/vendor_key.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/default_button/default_button.dart';
import 'package:easy_localization/easy_localization.dart';

class SuccessVendorBody extends StatelessWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;

  const SuccessVendorBody(
      {Key? key, this.isAddScreen, this.isEditScreen, required this.vData})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPress(context),
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
                  Text('vendor.label.registerVendor'.tr(),
                      style: TextStyleUtils.headingStyle()),
                if(this.isEditScreen == true)
                  Text('vendor.label.updateVendor'.tr(),
                      style: TextStyleUtils.headingStyle()),

                Text('common.label.isCompleted'.tr(
                    args: [this.vData[VendorKey.name]]),
                  textAlign: TextAlign.center,),
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
                  MaterialPageRoute(builder: (context) => VendorScreen()),
                );
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Future<bool> onBackPress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VendorScreen()),
    );
    return Future<bool>.value(true);
  }

}
