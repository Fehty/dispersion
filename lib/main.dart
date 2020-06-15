import 'package:dispersion/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('de', 'DE')
            ],
            theme:
                ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
            home: RootPage()));
  }
}
