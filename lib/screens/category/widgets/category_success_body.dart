import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/category/category_screen.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/category_key.dart';
import 'package:sale_management/shares/statics/default.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/text_style_util.dart';
import 'package:sale_management/shares/widgets/default_button/default_button.dart';
import 'package:easy_localization/easy_localization.dart';

class CategorySuccessBody extends StatefulWidget {
  final bool? isAddScreen;
  final bool? isEditScreen;
  final Map vData;
  CategorySuccessBody({Key? key, this.isEditScreen, this.isAddScreen, required this.vData}) : super(key: key);

  @override
  _CategorySuccessBodyState createState() => _CategorySuccessBodyState();
}

class _CategorySuccessBodyState extends State<CategorySuccessBody> {

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
                Text('category.label.registerCategory'.tr(),
                    style: TextStyleUtils.headingStyle()),
              if(widget.isEditScreen == true)
                Text('category.label.updateCategory'.tr(),
                    style: TextStyleUtils.headingStyle()),

              Text('category.message.isCompleted'.tr(
                  args: [widget.vData[CategoryKey.name]]),
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
        _buildAddButton(),
        // SizedBox(
        //   width: SizeConfig.screenWidth * 0.7,
        //   child: DefaultButton(
        //     elevation: 3,
        //     text: 'common.label.back'.tr(),
        //     color: Colors.green[800],
        //     press: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => CategoryScreen()),
        //       );
        //     },
        //   ),
        // ),
        Spacer(),
      ],
    );
  }

  Widget  _buildAddButton() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - getProportionateScreenWidth(70),
      child: RaisedButton(
        color: Color(0xff273965),
        textColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Stack(
          children: <Widget>[
            Center(child: Text('common.label.back'.tr(), style: TextStyle(
                fontFamily: fontDefault,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white),)
            ),
            Positioned(
                left: 0,
                top: 12.5,
                child: FaIcon(FontAwesomeIcons.arrowCircleLeft, size: 25, color: Colors.white)
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoryScreen()),
          );
        },
      ),
    );
  }

}
