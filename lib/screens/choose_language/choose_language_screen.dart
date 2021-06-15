import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/login/login_screen.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/database_sqflite/database/data_base_chose_language.dart';
import 'package:sale_management/shares/model/key/chose_language_key.dart';
import 'package:sale_management/shares/model/key/language_key.dart';
import 'package:sale_management/shares/statics/size_config.dart';
import 'package:sale_management/shares/utils/keyboard_util.dart';
import 'package:sale_management/shares/widgets/icon_check/icon_check.dart';
import 'package:easy_localization/easy_localization.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  List<dynamic> vData = [
    {
      LanguageKey.code: 'kh',
      LanguageKey.text: 'ខ្មែរ',
      'url': 'assets/countries/kh.svg'
    },
    {
      LanguageKey.code: 'en',
      LanguageKey.text: 'English',
      'url': 'assets/countries/gb.svg'
    }, {
      LanguageKey.code: 'zn',
      LanguageKey.text: '中文',
      'url': 'assets/countries/cn.svg'
    }
  ];
  late Size size;
  double height = 0.0;
  var code = 'en';
  var color = Color(0xff6E747F);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    SizeConfig.init(context);
    height = (size.height - SizeConfig.screenHeight * 0.06 -
        SizeConfig.screenHeight * 0.06);
    return Scaffold(
        backgroundColor: Color(0xff273955),
        body: Column(
            children: <Widget>[
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              Container(
                child: Center(
                  child: Text('Choose the language', style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: fontDefault)),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              // SizedBox(height: SizeConfig.screenHeight * 0.06),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide( //                    <--- top side
                        color: Colors.white,
                        width: 0.6,
                      ),
                    ),
                  ),
                  child: Column(
                    children: vData.map((e) => _container(e)).toList(),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  DataBaseChoseLanguage.getChooseLanguageById(1).then((value) async {
                    if (value.toString() == '{}') {
                      Map json = {
                        ChoseLanguageKey.id: 1,
                        ChoseLanguageKey.choose: '1'
                      };
                      DataBaseChoseLanguage.create(json).then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              LogInScreen()),
                        );
                      });
                    }
                    if (this.code == 'en') {
                      await context.setLocale(context.supportedLocales[0]);
                    } else if (this.code == 'kh') {
                      await context.setLocale(context.supportedLocales[1]);
                    }
                  });
                },
                child: _buildNextButton(),
              ),
            ]
        )
    );
  }


  Widget _container(Map map) {
    var isCheck = false;
    if (map[LanguageKey.code] == code) {
      isCheck = true;
    }
    return InkWell(
      onTap: () {
        setState(() {
          code = map[LanguageKey.code];
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: isCheck ? Border(
            top: BorderSide(width: 1, color: this.color),
            bottom: BorderSide(width: 1, color: this.color),
          ) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 55,
              height: 55,
              margin: EdgeInsets.all(15),
              child: _buildFlag(map['url'].toString()),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.only(top: 10),
                child: Text(map[LanguageKey.text], style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: fontDefault)),
              ),
            ),
            isCheck ? IconCheck() : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildFlag(String url) {
    return SvgPicture.asset(
      url.toString(),
      height: 50,
    );
  }

  Widget _buildNextButton() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.only(right: 10),
      child: RaisedButton(
        color: Color(0xff273965),
        textColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(child: Text('login.label.continue'.tr(), style: TextStyle(
                fontFamily: fontDefault,
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white),)
            ),
            Positioned(
                right: 0,
                top: 12.5,
                child: FaIcon(FontAwesomeIcons.arrowCircleRight, size: 25, color: Colors.white)
            ),
          ],
        ),
        onPressed: () {
          KeyboardUtil.hideKeyboard(context);
          Map json = {
            ChoseLanguageKey.id: 1,
            ChoseLanguageKey.choose: code
          };
          DataBaseChoseLanguage.create(json).then((value) async {
            if(value > 0) {
              await context.setLocale(context.supportedLocales[0]);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogInScreen()),
              );
            }
          });

        },
      ),
    );
  }

}
