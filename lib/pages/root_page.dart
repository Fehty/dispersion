import 'package:dispersion/constants.dart';
import 'package:dispersion/locale/app_localization.dart';
import 'package:dispersion/pages/info_page.dart';
import 'package:dispersion/pages/mono_light_page.dart';
import 'package:dispersion/pages/welcome_page.dart';
import 'package:dispersion/pages/white_light_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPage();
}

GlobalKey<ScaffoldState> _globalKeyScaffold = GlobalKey<ScaffoldState>();
ValueNotifier<Widget> currentPage = ValueNotifier(MonoLightPage());
ValueNotifier<bool> newAppEnter = ValueNotifier(true);
String currentLanguage = 'ru';
ValueNotifier<String> currLang = ValueNotifier('ru');
final GlobalKey<InnerDrawerState> innerDrawerKey =
    GlobalKey<InnerDrawerState>();

//AutomaticKeepAliveClientMixin, TickerProviderStateMixin
class _RootPage extends State<RootPage> with TickerProviderStateMixin {
  bool _visibility = true;

//  List<bool> _selections = [true, false];

//  @override
//  void initState() {
//    setState(() {
//      AppLocalization.load(Locale('ru', 'RU'));
//    });
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKeyScaffold,
        body: Stack(children: [
          ValueListenableBuilder(
              valueListenable: currentPage,
              builder: (BuildContext context, value, Widget child) => Container(
                    decoration: BoxDecoration(gradient: mainGradient),
                    child: InnerDrawer(
                        key: innerDrawerKey,
                        onTapClose: true,
                        proportionalChildArea: false,
//                offset: IDOffset.horizontal(0.273),
//                scale: IDOffset.horizontal(0.748),
                        offset: IDOffset.horizontal(
                            MediaQuery.of(context).size.height > 600
                                ? 0.273
                                : 0),
                        scale: IDOffset.horizontal(0.748),
                        backgroundColor: Colors.transparent,
                        colorTransition: Colors.white,
//                      backgroundDecoration:
//                      BoxDecoration(gradient: mainGradient),
//                      colorTransitionChild: Colors.transparent,
                        leftChild: LeftMenu(),
                        boxShadow: [],
                        borderRadius: 16,
                        scaffold: value),
                  )),
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
              })
        ]));
  }
}

class LeftMenu extends StatefulWidget {
  @override
  _LeftMenuState createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  space([double space = 8]) => SizedBox(height: space);
  List<bool> _selections;

//  bool isSelected;

  @override
  void initState() {
    if (currentLanguage == 'ru')
      _selections = [true, false];
    else
      _selections = [false, true];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget localizationToggle() {
      return ToggleButtons(
          children: <Widget>[Text('RU'), Text('EN')],
          color: Colors.white,
          selectedColor: Colors.white,
          fillColor: Color.fromRGBO(203, 206, 217, 1),
          splashColor: Colors.white30,
          borderWidth: 1.5,
          onPressed: (int index) {
            if (index == 0) {
//              currLang.value = 'ru';
              setState(() {
                AppLocalization.load(Locale('ru', 'RU'));
                _selections[1] = false;
                _selections[0] = true;
                currentLanguage = 'ru';
              });

//              widget.update();
            } else if (index == 1) {
//              currLang.value = 'en';
              setState(() {
                AppLocalization.load(Locale('en', 'US'));
                _selections[0] = false;
                _selections[1] = true;
                currentLanguage = 'en';
              });
//              widget.update();
            }
          },
          isSelected: _selections);
    }

    Widget menuItems(bool isSmallScreen) {
      getMenuItem({@required Function onTap,
        @required var icon,
        @required String text,
        double space = 16}) {
        return GestureDetector(
            onTap: onTap,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 24), child: icon),
                  SizedBox(width: space),
                  Flexible(child: Text(text, style: leftMenuTextStyle))
                ])));
      }

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        space(MediaQuery
            .of(context)
            .size
            .height * 0.125),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .height > 600 ? 170 : 240,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height > 600 ? 170 : 240,
                  child:
                  Image(image: AssetImage('assets/images/new_logo.png'))),
              space(),
//        Text('Дисперсия', style: leftMenuTextStyle.copyWith(fontSize: 30)),
              Text(AppLocalization
                  .of(context)
                  .appName,
                  style: leftMenuTextStyle.copyWith(fontSize: 30))
            ],
          ),
        ),
        space(MediaQuery
            .of(context)
            .size
            .height > 600 ? 72 : 52),
        getMenuItem(
            onTap: () {
//              currentPage.value = WhiteLightPage();
//              Navigator.of(context).push(CupertinoPageRoute<void>(
//                  builder: (BuildContext context) => WhiteLightPage()));
              currentPage.value = WhiteLightPage();
              innerDrawerKey.currentState.close();
            },
            icon: Image(
                image: AssetImage('assets/images/white_light.png'),
                color: Colors.white,
                width: 24,
                height: 24),
            text: AppLocalization
                .of(context)
                .whiteLight),
        space(),
        getMenuItem(
            onTap: () {
//              currentPage.value = MonoLightPage();
//              Navigator.of(context).push(CupertinoPageRoute<void>(
//                  builder: (BuildContext context) => MonoLightPage()));
              currentPage.value = MonoLightPage();
              innerDrawerKey.currentState.close();
            },
            icon: Image(
                image: AssetImage('assets/images/monochromatic.png'),
                color: Colors.white,
                width: 27,
                height: 27),
            space: 13,
            text: AppLocalization
                .of(context)
                .monoLight),
        space(),
        getMenuItem(
            onTap: () {
//              Future.delayed(Duration(milliseconds: 300))
//                  .then((value) => currentPage.value = AboutPage());
//              Navigator.of(context).push(CupertinoPageRoute(
//                  builder: (BuildContext context) => AboutPage()));
              currentPage.value = InfoPage();
              innerDrawerKey.currentState.close();
            },
            icon: Image(
                image: AssetImage('assets/images/info.png'),
                color: Colors.white,
                width: 24,
                height: 24),
            text: AppLocalization
                .of(context)
                .info),

        isSmallScreen ? space(24) : Spacer(),
//        Spacer(),
        space(24),
        Padding(
            padding: const EdgeInsets.only(left: 24),
            child: localizationToggle()),
//        Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: [

//            SizedBox(width: 48),
//
//          ],
//        ),
        space(24),
//        space(MediaQuery.of(context).size.height * 0.08),
//        if (MediaQuery.of(context).size.height > 600)
//          Align(
//              alignment: Alignment.bottomRight,
//              child: Padding(
//                  padding: const EdgeInsets.only(right: 16, bottom: 16),
//                  child: localizationToggle()))
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
