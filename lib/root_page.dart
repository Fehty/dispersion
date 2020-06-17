import 'package:dispersion/about_page.dart';
import 'package:dispersion/constants.dart';
import 'package:dispersion/mono_light_page.dart';
import 'package:dispersion/welcome_page.dart';
import 'package:dispersion/white_light_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPage();
}

GlobalKey<ScaffoldState> _globalKeyScaffold = GlobalKey<ScaffoldState>();
ValueNotifier<Widget> currentPage = ValueNotifier(MonoLightPage());
ValueNotifier<bool> newAppEnter = ValueNotifier(true);

final GlobalKey<InnerDrawerState> innerDrawerKey =
    GlobalKey<InnerDrawerState>();

class _RootPage extends State<RootPage> {
  bool _visibility = true;
  List<bool> _selections = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKeyScaffold,
        body: Stack(children: [
          ValueListenableBuilder(
              valueListenable: currentPage,
              builder: (BuildContext context, value, Widget child) =>
                  InnerDrawer(
                      key: innerDrawerKey,
                      onTapClose: true,
//                offset: IDOffset.horizontal(0.273),
//                scale: IDOffset.horizontal(0.748),
                      offset: IDOffset.horizontal(0.273),
                      scale: IDOffset.horizontal(0.748),
                      backgroundDecoration:
                          BoxDecoration(gradient: mainGradient),
                      colorTransitionChild: Colors.transparent,
                      leftChild: LeftMenu(),
                      boxShadow: [],
                      borderRadius: 15,
                      scaffold: value)),
          ValueListenableBuilder(
              valueListenable: newAppEnter,
              builder: (BuildContext context, value, Widget child) {
                if (!value)
                  Future.delayed(Duration(milliseconds: 600))
                      .then((value) => setState(() => _visibility = false));
                return Visibility(
                    visible: _visibility,
                    child: AnimatedOpacity(
                        opacity: value ? 1 : 0,
                        duration: Duration(milliseconds: 600),
                        child: WelcomePage()));
              }),
//          Align(
//              alignment: Alignment.bottomRight,
//              child: Padding(
//                  padding: const EdgeInsets.only(right: 16, bottom: 16),
//                  child: ToggleButtons(
//                      children: <Widget>[Text('RU'), Text('EN')],
//                      color: Colors.white,
//                      selectedColor: Colors.white,
//                      fillColor: Color.fromRGBO(203, 206, 217, 1),
//                      splashColor: Colors.white30,
//                      borderWidth: 1.5,
//                      onPressed: (int index) {
//                        if (index == 0) {
//                          setState(() {
//                            _selections[1] = false;
//                            _selections[0] = true;
//                          });
//                        } else if (index == 1) {
//                          setState(() {
//                            _selections[0] = false;
//                            _selections[1] = true;
//                          });
//                        }
//                      },
//                      isSelected: _selections)))
        ]));
  }
}

class LeftMenu extends StatefulWidget {
  @override
  _LeftMenuState createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  space([double space = 8]) => SizedBox(height: space);

//  bool isSelected;
  @override
  Widget build(BuildContext context) {
    getMenuItem({@required Function onTap,
      @required var icon,
      @required String text,
      double space = 16}) {
      return GestureDetector(
          onTap: onTap,
          child: Container(
              color: Colors.transparent,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 24), child: icon),
                    SizedBox(width: space),
                    Flexible(child: Text(text, style: leftMenuTextStyle))
                  ]))));
    }

    Widget menuItems(bool isSmallScreen) {
      return Column(children: [
        space(MediaQuery
            .of(context)
            .size
            .height * 0.13),
        AspectRatio(
            aspectRatio: 1.4,
            child: Image(image: AssetImage('assets/images/new_logo.png'))),
        space(),
        Text('Дисперсия', style: leftMenuTextStyle.copyWith(fontSize: 30)),
        space(52),
        getMenuItem(
            onTap: () {
              currentPage.value = WhiteLightPage();
              Navigator.of(context).push(CupertinoPageRoute<void>(
                  builder: (BuildContext context) => WhiteLightPage()));
            },
            icon: Image(
                image: AssetImage('assets/images/white_light.png'),
                color: Colors.white,
                width: 24,
                height: 24),
            text: "Белое изл."),
        space(),
        getMenuItem(
            onTap: () {
              currentPage.value = MonoLightPage();
              Navigator.of(context).push(CupertinoPageRoute<void>(
                  builder: (BuildContext context) => MonoLightPage()));
            },
            icon: Image(
                image: AssetImage('assets/images/monochromatic.png'),
                color: Colors.white,
                width: 27,
                height: 27),
            space: 13,
            text: "Монохр. изл."),
        space(),
        getMenuItem(
            onTap: () {
              Future.delayed(Duration(milliseconds: 300))
                  .then((value) => currentPage.value = AboutPage());
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (BuildContext context) => AboutPage()));
            },
            icon: Image(
                image: AssetImage('assets/images/info.png'),
                color: Colors.white,
                width: 24,
                height: 24),
            text: "Информация"),

        isSmallScreen ? space(24) : Spacer(),
//        Spacer(),
        space(24),
        getMenuItem(
            onTap: () => SystemNavigator.pop(),
            icon: Image(
                image: AssetImage('assets/images/exit.png'),
                color: Colors.white,
                width: 23,
                height: 23),
            text: "Выход"),

        space(MediaQuery
            .of(context)
            .size
            .height * 0.08)
      ]);
    }

    if (MediaQuery.of(context).size.height > 600)
      return menuItems(false);
    else
      return Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SizedBox(
              height: 800,
              child: SingleChildScrollView(child: menuItems(true))));
  }
}
