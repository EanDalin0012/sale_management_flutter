import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/screens/setting/widgets/language_choice.dart';
import 'package:sale_management/screens/setting/widgets/profile_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:sale_management/shares/model/key/language_key.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sale_management/shares/model/key/m_key.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({Key? key}) : super(key: key);

  @override
  _SettingBodyState createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  var style = TextStyle(fontFamily: fontDefault, fontWeight: FontWeight.w500);
  var language = 'English';
  var languageCode = 'en';
  late FToast fToast;
  List<dynamic> vDataStock = [];
  Map vStock = {};

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    this._fetchItemsStock();
  }

  @override
  Widget build(BuildContext context) {
    this.languageCode = context.locale.toString();
    if(this.languageCode == 'km') {
      this.language = 'ខ្មែរ';
    } else if (this.languageCode == 'zn') {
      this.language = '中文';
    }
    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ProfileHeader(
              avatar: 'https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg',
              coverImage: 'https://machinecurve.com/wp-content/uploads/2019/07/thispersondoesnotexist-1-1022x1024.jpg',
              title: "Ramesh Mana",
              subtitle: "Manager",
              actions: <Widget>[
                MaterialButton(
                  color: Colors.white,
                  shape: CircleBorder(),
                  elevation: 0,
                  child: Icon(Icons.edit),
                  onPressed: () {},
                )
              ],
            ),

            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'setting.label.userInformation'.tr(),
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 2,
                  ),
                  _buildListTile(title: 'Ean Dalin', svgIcon: 'assets/icons/User.svg'),
                  Divider(
                    height: 2,
                  ),
                  Divider(),
                  _buildListTile(title: '20201548', svgIcon: 'assets/icons/featured_play_list_black_24dp.svg'),
                  Divider(
                    height: 2,
                  ),
                ],
              ),
            ),

            Container(
              height: 50,
              padding: EdgeInsets.only(
                  left: 10,
                  top: 17
              ),
              decoration: BoxDecoration(
                  color: Color(0xCD939BA9).withOpacity(0.3)
              ),
              width: MediaQuery.of(context).size.width,
              child: Text('setting.label.chooseLanguage'.tr(), style: style,),
            ),

            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content: LanguageChoice(
                            code: languageCode,
                            onChanged: (data) async {
                              setState(() {
                                this.language = data[LanguageKey.text];
                                this.languageCode = data[LanguageKey.code];
                              });
                              if(data[LanguageKey.code] == 'en') {
                                await context.setLocale(context.supportedLocales[0]);
                              } else if (data[LanguageKey.code] == 'km') {
                                await context.setLocale(context.supportedLocales[1]);
                              }
                              _showToast();
                            },
                          )
                      );
                    }
                );
              },
              child: Container(
                height: 60,
                padding: EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10
                ),
                child: Row(
                    children: <Widget>[
                      _listTileLeading(
                          height: 25,
                          width: 20,
                          svgIcon: 'assets/icons/language_black_24dp.svg'
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('${this.language}', style: style,))
                    ],
                  ),
              ),
            ),

            this.vStock != null ? Container(
              height: 50,
              padding: EdgeInsets.only(
                  left: 10,
                  top: 17
              ),
              decoration: BoxDecoration(
                  color: Color(0xCD939BA9).withOpacity(0.3)
              ),
              width: MediaQuery.of(context).size.width,
              child: Text('setting.label.saleFromStock'.tr(), style: style,),
            ) : Container(),

            this.vStock != null  ? GestureDetector(
              onTap: () => changeStock(this.vDataStock[0]),
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.database,),
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text('${this.vStock[StockKey.name]}', style: style,))
                  ],
                ),
              ),
            ) : Container(),

          ],
        ),
    );
  }

  Container _buildListTile({required String title, required String svgIcon}) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: <Widget>[
          _listTileLeading(
              height: 25,
              width: 20,
              svgIcon: svgIcon
          ),
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(title, style: style,))
        ],
      ),
    );
  }

  Padding _listTileLeading({
    required String svgIcon,
    Color? color,
    double? width,
    double? height,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0,0,0,0),
      child: SvgPicture.asset(
        svgIcon,
        width: width,
        height: height,
        color: color,
      ),
    );
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text('setting.label.changedLanguage'.tr(args: [this.language])),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

    // // Custom Toast Position
    // fToast.showToast(
    //     child: toast,
    //     toastDuration: Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         child: child,
    //         top: 16.0,
    //         left: 16.0,
    //       );
    //     });
  }

  _fetchItemsStock() async {
    final data = await rootBundle.loadString('assets/json_data/stock_list.json');
    Map mapItems = jsonDecode(data);
    setState(() {
      this.vDataStock = mapItems['stocks'];
      this.vStock = this.vDataStock[0];
    });
    return this.vDataStock;
  }

  changeStock(Map vStock) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: LanguageChoice(
                code: languageCode,
                onChanged: (data) async {
                  setState(() {
                    this.language = data[LanguageKey.text];
                    this.languageCode = data[LanguageKey.code];
                  });
                  if(data[LanguageKey.code] == 'en') {
                    await context.setLocale(context.supportedLocales[0]);
                  } else if (data[LanguageKey.code] == 'km') {
                    await context.setLocale(context.supportedLocales[1]);
                  }
                  _showToast();
                },
              )
          );
        }
    );
  }


}
