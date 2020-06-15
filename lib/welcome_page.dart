import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AspectRatio(
              aspectRatio: 1.7,
              child: Image(image: AssetImage('assets/images/logo.png'))),
          SizedBox(height: 12),
          Flexible(
              child: Text('Дисперсия',
                  style: leftMenuTextStyle.copyWith(fontSize: 30)))
        ]));
  }
}
