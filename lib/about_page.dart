import 'package:dispersion/root_page.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _info =
      'Свет – электромагнитная волна.\n\nВидимый свет – это волны, имеющие длину в интервале от 380 до 760 нанометров(от фиолетового до красного) включительно.\n\nЕще в 1672 году Ньютон заметил, что показатель преломления зависит от длины волны. Другими словами, красный свет, падая на поверхность и преломляясь, отклонится на другой угол, нежели желтый, зеленый и так далее. Эта зависимость и называется дисперсией.\n\nРадуга - результат дисперсии!Пропуская белый свет через призму, можно получить спектр, состоящий из всех цветов радуги. Это явление напрямую объясняется дисперсией света. Раз показатель преломления зависит от длины волны, значит, он зависит и от частоты. Соответственно, скорость света для разных длин волн в веществе также будет различна.\n\nДисперсия света – зависимость скорости света в веществе от частоты.\n\nГде применяется дисперсия света? Во многих областях сфер, например, в искусстве(радуга), промышленности(краски, добавки для тканей), бытовой химии(подкрахмаливающие средства). Также можно наблюдать цветную "игру света" на гранях бриллианта, если идет речь про ювелирное дело.\n\nДисперсия света - интересное физическое явление, которое подарила природа!';
  String _firstHalf;
  String _secondHalf;

  @override
  void initState() {
    _firstHalf = _info.substring(0, 436);
    _secondHalf = _info.substring(436, _info.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // her
            child: AppBar(
                backgroundColor: Color.fromRGBO(78, 133, 172, 1),
                leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => innerDrawerKey.currentState.open()),
                title: const Text('Информация'))),
        body: ListView(
            padding: const EdgeInsets.all(0),
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 24),
//              Padding(
//                  padding: const EdgeInsets.only(left: 16, right: 16),
//                  child: GradientText('Информация',
//                      textStyle: Theme.of(context).textTheme.headline4,
//                      gradient: mainGradient)),
//              SizedBox(height: 16),
              Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(_firstHalf.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.blueGrey))),
              SizedBox(height: 8),
              Image(
                  image: AssetImage('assets/images/rainbow.jpg'),
                  fit: BoxFit.fitWidth),
              SizedBox(height: 8),
              Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(_secondHalf.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.blueGrey))),
              SizedBox(height: 24)
            ]));
  }
}
