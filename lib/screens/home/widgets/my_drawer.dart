import 'package:flutter/material.dart';
import 'package:sale_management/shares/constants/fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  var size ;
  var style = TextStyle(fontFamily: fontDefault, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Drawer(
        child: Scaffold(
          body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 15),
                            color: Color(0xFF88070B),
                            child:Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset("assets/images/profile.jpg", width: 80, height: 80, fit: BoxFit.fill,),
                                ),
                                SizedBox(width: 15,),
                                RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(text: "Name Surname\n", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: fontDefault, color: Colors.white)),
                                          TextSpan(text: "@username", style: TextStyle(fontFamily: fontDefault, color: Colors.white)),
                                        ]
                                    )
                                )
                              ],
                            )
                        ),
                        ListTile(title: Text('drawer.label.contactUs'.tr(), style: style,), leading: Icon(Icons.phone),),
                        ListTile(title: Text('drawer.label.termsCondition'.tr(), style: style), leading: Icon(Icons.card_giftcard),),
                        Divider(),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SettingScreen()),
                            // );
                          },
                          title: Text('drawer.label.settings'.tr(),style: style), leading: Icon(Icons.settings),
                        ),
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: new Text(
                                'drawer.label.logout'.tr(),
                                style: new TextStyle(
                                  // fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  // color: AppTheme.darkText,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              trailing: new Icon(
                                Icons.power_settings_new,
                                color: Colors.red,
                              ),
                              onTap: () {
                                // Navigator.pop(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => SignInScreen()),
                                // );
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0,),
                      color: Color(0XFFAEA1E5).withOpacity(0.3),
                      child: Text("2.20.00"),
                    )
                )
              ]
          )
        )
    );
  }
}