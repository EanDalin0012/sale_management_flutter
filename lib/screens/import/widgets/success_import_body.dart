import 'package:flutter/material.dart';
import 'package:sale_management/screens/import/import_screen.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/widgets/default_button/default_button.dart';

class SuccessImportBody extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;
  const SuccessImportBody({Key? key, this.isAddScreen, this.isEditScreen, required this.vData}) : super(key: key);

  @override
  _SuccessImportBodyState createState() => _SuccessImportBodyState();
}

class _SuccessImportBodyState extends State<SuccessImportBody> {

  late Map product = {};


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: SizeConfig.screenHeight * 0.07),
        Center(
          child: Image.asset(
            DefaultStatic.assetsSuccessPathImage,
            height: SizeConfig.screenHeight * 0.2, //40%
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.07),
        Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
              if (widget.isAddScreen == true)
                Text('import.label.importNewProduct'.tr(), style: TextStyleUtils.headingStyle()),
              if(widget.isEditScreen == true)
                Text('import.label.importNewProduct'.tr(), style: TextStyleUtils.headingStyle()),

              //Text('category.message.isCompleted'.tr(args: [widget.vData[ImportKey.name]]),textAlign: TextAlign.center,),
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
                MaterialPageRoute(builder: (context) => ImportScreen()),
              );

            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
