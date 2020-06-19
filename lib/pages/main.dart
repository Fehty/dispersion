import 'package:dispersion/locale/app_localization.dart';
import 'package:dispersion/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLocalizationDelegate localeOverrideDelegate =
      AppLocalizationDelegate(Locale('ru', 'RU'));

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (scroll) {
          scroll.disallowGlow();
          return true;
        },
        child: MaterialApp(
            title: 'Dispersion',
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localeOverrideDelegate
            ],
            supportedLocales: [
              const Locale('ru', 'RU'),
              const Locale('en', 'US')
            ],
            theme:
                ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
            home: RootPage()));
  }
}
