import 'package:dispersion/constants.dart';
import 'package:dispersion/mono_light_page.dart';
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

class _RootPage extends State<RootPage> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

//  void toggle() {
//    setState(() {
//      _innerDrawerKey.currentState.open();
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKeyScaffold,
        body: ValueListenableBuilder(
          valueListenable: currentPage,
          builder: (BuildContext context, value, Widget child) => InnerDrawer(
              key: _innerDrawerKey,
              onTapClose: true,
              offset: IDOffset.horizontal(0.273),
              scale: IDOffset.horizontal(0.748),
              backgroundDecoration: BoxDecoration(gradient: mainGradient),
              colorTransitionChild: Colors.transparent,
              leftChild: LeftMenu(),
              boxShadow: [],
              borderRadius: 15,
              scaffold: value),
        ));
  }
}

class LeftMenu extends StatefulWidget {
  @override
  _LeftMenuState createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  space([double space = 8]) {
    return SizedBox(height: space);
  }

  @override
  Widget build(BuildContext context) {
    getMenuItem(
        {@required Function onTap, @required var icon, @required String text}) {
      return GestureDetector(
          onTap: onTap,
          child: Container(
              color: Colors.transparent,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Icon(icon, color: Colors.white)),
                    SizedBox(width: 16),
                    Flexible(child: Text(text, style: leftMenuTextStyle))
                  ]))));
    }

    Widget menuItems(bool isSmallScreen) {
      return Column(children: [
        space(MediaQuery.of(context).size.height * 0.135),
        AspectRatio(
            aspectRatio: 1.4,
            child: Image(image: AssetImage('assets/images/dispersion.png'))),
        space(72),
        getMenuItem(
            onTap: () {
              currentPage.value = MonoLightPage();
              Navigator.of(context).push(CupertinoPageRoute<void>(
                  builder: (BuildContext context) => MonoLightPage()));
            },
            icon: Icons.lightbulb_outline,
            text: "Monochromatic"),
        space(),
        getMenuItem(
            onTap: () {
              currentPage.value = Container(color: Colors.green);
              Navigator.of(context).push(CupertinoPageRoute<void>(
                  builder: (BuildContext context) =>
                      Container(color: Colors.green)));
            },
            icon: Icons.highlight,
            text: "White light"),
        space(),
        getMenuItem(
            onTap: () {
              Future.delayed(Duration(milliseconds: 300)).then(
                  (value) => currentPage.value = Container(color: Colors.blue));
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (BuildContext context) =>
                      Container(color: Colors.blue)));
            },
            icon: Icons.info,
            text: "About"),
        Spacer(),
        getMenuItem(
            onTap: () => SystemNavigator.pop(),
            icon: Icons.exit_to_app,
            text: "Exit"),
        space(MediaQuery
            .of(context)
            .size
            .height * 0.125)
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
