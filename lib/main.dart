import 'package:dispersion/root_page.dart';
import 'package:flutter/material.dart';

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
            theme:
                ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
            home: RootPage()));
  }
}
