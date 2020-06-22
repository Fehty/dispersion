import 'package:dispersion/locale/app_localization.dart';
import 'package:dispersion/pages/root_page.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String _firstHalf;
  String _secondHalf;

  int middleValue;

  @override
  Widget build(BuildContext context) {
    if (currentLanguage == 'ru') middleValue = 436;
    if (currentLanguage == 'en') middleValue = 448;
    _firstHalf = AppLocalization.of(context).infoText.substring(0, middleValue);
    _secondHalf = AppLocalization.of(context)
        .infoText
        .substring(middleValue, AppLocalization.of(context).infoText.length);
    return Scaffold(
        backgroundColor: Colors.black,
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) =>
                [
                  SliverAppBar(
                      backgroundColor: Color.fromRGBO(78, 133, 172, 1),
                      leading: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () => innerDrawerKey.currentState.open()),
                      title: Text(AppLocalization.of(context).info))
                ],
            body: ListView(
                padding: const EdgeInsets.all(12),
                physics: BouncingScrollPhysics(),
                children: [
                  Text(_firstHalf.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.blueGrey)),
                  Image(
                      image: AssetImage('assets/images/rainbow.jpg'),
                      height: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * 0.7
                          : MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width
                          : MediaQuery.of(context).size.width * 0.4),
                  Text(_secondHalf.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.blueGrey))
                ])));
  }
}
