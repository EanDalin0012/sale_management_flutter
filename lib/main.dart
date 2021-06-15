import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sale_management/screens/choose_language/choose_language_screen.dart';
import 'package:sale_management/screens/login/login_screen.dart';
import 'package:sale_management/shares/database_sqflite/database/data_base_chose_language.dart';
import 'package:sale_management/shares/database_sqflite/database/data_base_dark_mode.dart';
import 'package:sale_management/shares/model/key/dark_mode_key.dart';
import 'package:sale_management/shares/provider/main_provider.dart';
import 'package:sale_management/shares/statics/dark_mode_color.dart';
import 'package:sale_management/shares/utils/device_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider())
      ],
      child: EasyLocalization(
          child: MyApp(),
          supportedLocales: [
            Locale('en'),
            Locale('km')
          ],
          fallbackLocale: Locale('en'),
          saveLocale: true,
          path: 'assets/i18n'
      )
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late bool chose = false;
  late FToast fToast;
  var initPlatformState = '';

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    DataBaseDarkModeUtils.getDarkModeById(1).then((value) {
      if (value.toString() == '{}') {
        Map json = {
          DarkModeKey.id: 1,
          DarkModeKey.code: '1' // 1=> true, 0=> false
        };
        DataBaseDarkModeUtils.create(json).then((value) {
          if (value > 0) {
            DarkMode.isDarkMode = false;
          }
        });
      } else {
        setState(() {
          Map data = value;
          if (data[DarkModeKey.code].toString() == '1') {
            DarkMode.isDarkMode = true;
          } else {
            DarkMode.isDarkMode = false;
          }
        });
      }
    });
    DataBaseChoseLanguage.getChooseLanguageById(1).then((value) {
      print("value"+value.toString());
      setState(() {
        if (value.toString() == '{}') {
          this.chose = false;
        } else {
          this.chose = true;
        }
      });
    });

    DeviceInfoUtils.initPlatformState().then((value) {
      print(value.toString());
      this.initPlatformState = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ToastUtils.showToast(context: 'initPlatformState:'+initPlatformState.toString(), fToast: fToast);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: context.watch<MainProvider>().theme(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: this.chose ? LogInScreen() : ChooseLanguageScreen() //LogInScreen(),
    );
  }

}
//
// class MyApp1 extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: context.watch<MainProvider>().theme(),
//       localizationsDelegates: context.localizationDelegates,
//       supportedLocales: context.supportedLocales,
//       locale: context.locale,
//       home: LogInScreen(),
//     );
//   }
// }
