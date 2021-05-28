import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:sale_management/screens/login/login_screen.dart';
import 'package:sale_management/shares/provider/main_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>MainProvider())
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: context.watch<MainProvider>().theme(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: LogInScreen(),
    );
  }
}
