import 'package:dispersion/locale/app_localization.dart';
import 'package:dispersion/pages/root_page.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
//  String _info =
//      'Свет – электромагнитная волна.\n\nВидимый свет – это волны, имеющие длину в интервале от 380 до 760 нанометров(от фиолетового до красного) включительно.\n\nЕще в 1672 году Ньютон заметил, что показатель преломления зависит от длины волны. Другими словами, красный свет, падая на поверхность и преломляясь, отклонится на другой угол, нежели желтый, зеленый и так далее. Эта зависимость и называется дисперсией.\n\nРадуга - результат дисперсии!Пропуская белый свет через призму, можно получить спектр, состоящий из всех цветов радуги. Это явление напрямую объясняется дисперсией света. Раз показатель преломления зависит от длины волны, значит, он зависит и от частоты. Соответственно, скорость света для разных длин волн в веществе также будет различна.\n\nДисперсия света – зависимость скорости света в веществе от частоты.\n\nГде применяется дисперсия света? Во многих сферах, например, в искусстве(радуга), промышленности(краски, добавки для тканей), бытовой химии(подкрахмаливающие средства). Также можно наблюдать цветную "игру света" на гранях бриллианта, если идет речь про ювелирное дело.\n\nДисперсия света - интересное физическое явление, которое подарила природа!';
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
//        appBar: PreferredSize(
//            preferredSize: Size.fromHeight(60.0), // her
//            child: AppBar(
//                backgroundColor: Color.fromRGBO(78, 133, 172, 1),
//                leading: IconButton(
//                    icon: const Icon(Icons.menu),
//                    onPressed: () => innerDrawerKey.currentState.open()),
//                title: const Text('Информация'))),
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
                padding: const EdgeInsets.all(0),
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 12),
//              Padding(
//                  padding: const EdgeInsets.only(left: 16, right: 16),
//                  child: GradientText('Информация',
//                      textStyle: Theme.of(context).textTheme.headline4,
//                      gradient: mainGradient)),
//              SizedBox(height: 16),
                  Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text(_firstHalf.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.blueGrey))),
//                  SizedBox(height: 4),
                  Image(
                      image: AssetImage('assets/images/rainbow.jpg'),
                      fit: BoxFit.fitWidth),
//                  SizedBox(height: 4),
                  Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text(_secondHalf.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.blueGrey))),
                  SizedBox(height: 12)
                ])));
  }
}
