import 'package:flutter/material.dart';
import 'package:sale_management/screens/member/member_screen.dart';
import 'package:sale_management/shares/model/key/member_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/default_button/default_button.dart';
import 'package:easy_localization/easy_localization.dart';

class MemberSuccessBody extends StatelessWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;

  MemberSuccessBody(
      {Key? key, this.isEditScreen, this.isAddScreen, required this.vData})
      : super(key: key);

  GlobalKey<NavigatorState> _key = GlobalKey();

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
              if (this.isAddScreen == true)
                Text('member.label.registerMember'.tr(),
                    style: TextStyleUtils.headingStyle()),
              if(this.isEditScreen == true)
                Text('member.label.updateMember'.tr(),
                    style: TextStyleUtils.headingStyle()),

              Text('common.label.isCompleted'.tr(
                  args: [this.vData[MemberKey.name]]),
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
                MaterialPageRoute(builder: (context) => MemberScreen()),
              );
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
