import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                width: MediaQuery.of(context).size.height > 600 ? 220 : 240,
                height: MediaQuery.of(context).size.height > 600 ? 220 : 240,
                child: Image(image: AssetImage('assets/images/logo.png'))),
//            SizedBox(height: 12),
//            Flexible(
//                child: GradientText('Dispersion',
//                    textStyle: leftMenuTextStyle.copyWith(fontSize: 30),
//                    gradient: rainbowGradient))
//          Flexible(
//              child: Text('Дисперсия',
//                  style: leftMenuTextStyle.copyWith(
//                      fontSize: 30, color: Colors.black)))
          ]),
        ));
  }
}
