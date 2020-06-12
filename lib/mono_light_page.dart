import 'package:dispersion/constants.dart';
import 'package:dispersion/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class MonoLightPage extends StatefulWidget {
  MonoLightPage({Key key}) : super(key: key);

  @override
  _MonoLightPageState createState() => _MonoLightPageState();
}

class _MonoLightPageState extends State<MonoLightPage> {
  double waveSliderValue = 0.0;
  int waveValue = 350;

  double angleSliderValue = 0.0;
  int angleValue = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height < 600
                    ? 700
                    : MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Column(children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 24, top: 65),
                          child: GradientText('Light Dispersion',
                              gradient: mainGradient,
                              textStyle:
                              Theme.of(context).textTheme.headline4))),
                  SizedBox(height: 82),
                  SizedBox(
                      width: 320,
                      height: 320,
                      child: CustomPaint(
                          painter: MyPainter(
                              angleSliderValue, angleValue, waveValue))),
                  Spacer(),
                  Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(children: [
                        GradientText('α = $angleValue°',
                            gradient: mainGradient,
                            textStyle: Theme.of(context).textTheme.headline4),
                        Spacer(),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    trackHeight: 3.0,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 12.0)),
                                child: ShaderMask(
                                    shaderCallback: (bounds) =>
                                        mainGradient.createShader(Rect.fromLTWH(
                                            0, 0, bounds.width, bounds.height)),
                                    child: Slider(
                                        value: angleSliderValue,
                                        activeColor: Colors.white,
                                        inactiveColor:
                                        Color.fromRGBO(138, 171, 193, 0.4),
                                        onChanged: (double value) {
                                          setState(() {
                                            angleSliderValue = value;
                                            angleValue =
                                                (angleSliderValue * 30 + 20)
                                                    .toInt();
                                          });
                                        }))))
                      ])),
                  Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GradientText('λ = $waveValue',
                                gradient: mainGradient,
                                textStyle:
                                Theme.of(context).textTheme.headline4),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: GradientText(' нм',
                                    gradient: mainGradient,
                                    textStyle:
                                    Theme.of(context).textTheme.headline5)),
                            Spacer(),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                        trackHeight: 3.0,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 12.0)),
                                    child: ShaderMask(
                                        shaderCallback: (bounds) => mainGradient
                                            .createShader(Rect.fromLTWH(0, 0,
                                            bounds.width, bounds.height)),
                                        child: Slider(
                                            value: waveSliderValue,
                                            activeColor: Colors.white,
                                            inactiveColor: Color.fromRGBO(
                                                138, 171, 193, 0.4),
                                            onChanged: (double value) {
                                              setState(() {
                                                waveSliderValue = value;
                                                waveValue =
                                                    (410 * waveSliderValue +
                                                        350)
                                                        .toInt();
                                              });
                                            }))))
                          ])),
                  SizedBox(height: 24)
                ]))),
//      bottomNavigationBar: BottomNavigationBar(
//        backgroundColor: Colors.black,
//        unselectedItemColor:   Colors.white,
//
//        currentIndex: 1, // this will be set when a new tab is tapped
//        items: [
//          BottomNavigationBarItem(
//            backgroundColor: Colors.white,
//
//            icon: new Icon(Icons.home),
//            title: new Text('Home'),
//          ),
//          BottomNavigationBarItem(
//            icon: new Icon(Icons.mail),
//            title: new Text('Messages'),
//          ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.person),
//              title: Text('Profile')
//          )
//        ],
//      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final angleSliderValue;
  final angleValue;

  final waveValue;

  MyPainter(this.angleSliderValue, this.angleValue, this.waveValue);

  final mainLinePaint = Paint();
  final perpendicularLinePaint = Paint();
  final yellowAnglePaint = Paint();
  final perpendicularRectanglePaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    mainLinePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..color = waveValue > 640 || waveValue == 640
          ? Colors.red
          : waveValue < 640 && waveValue > 600 || waveValue == 600
          ? Colors.orange
              : waveValue < 600 && waveValue > 590 || waveValue == 590
                  ? Colors.yellow
                  : waveValue < 590 && waveValue > 485 || waveValue == 485
                      ? Colors.lightGreen
                      : waveValue < 485 && waveValue > 465 || waveValue == 465
                          ? Colors.cyanAccent
                          : waveValue < 465 && waveValue > 420 ||
                                  waveValue == 420
                              ? Colors.blue
          : waveValue < 420 && waveValue > 385 ||
          waveValue == 385
          ? Color.fromRGBO(0, 13, 255, 1)
          : waveValue < 385 && waveValue > 370 ||
          waveValue == 370
          ? Color.fromRGBO(82, 0, 255, 1)
          : waveValue < 370 && waveValue > 345 ||
          waveValue == 345
          ? Color.fromRGBO(113, 49, 160, 1)
          : Colors.blue;
    perpendicularLinePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;
    yellowAnglePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.yellow;
    perpendicularRectanglePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.red;

    drawTriangle(canvas, size);
    drawAngle(canvas, size);
    drawFirstLine(canvas, size);
    drawFirstLinePerpendicular(canvas, size);
    drawMiddleLine(canvas, size);
    drawThirdLine(canvas, size);
    drawThirdLinePerpendicular(canvas, size);
  }

  void drawTriangle(Canvas canvas, Size size) {
    double widthCalcValue = angleSliderValue * 106;
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final trianglePaint = Paint()..shader = mainGradient.createShader(rect);
    var trianglePath = Path();
    trianglePath.moveTo(size.width / 2, 0);
    trianglePath.lineTo(size.width / 3 - widthCalcValue, size.height);
    trianglePath.lineTo(
        size.width - size.width / 3 + widthCalcValue, size.height);
    trianglePath.close();
    canvas.drawPath(trianglePath, trianglePaint);
  }

  void drawAngle(Canvas canvas, Size size) {
    final anglePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.black;
    canvas.drawCircle(Offset(size.width / 2, 0), 70, anglePaint);
    final textPainter = TextPainter(
        text: TextSpan(
            text: 'α', style: TextStyle(color: Colors.black, fontSize: 30)),
        textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final offset = Offset(size.width / 2 - 8, 70);
    textPainter.paint(canvas, offset);
  }

  void drawFirstLine(Canvas canvas, Size size) {
    double widthCalcValue = angleSliderValue * 100;
    double x1 = size.width / 3 - widthCalcValue;

    canvas.drawLine(Offset(-250, size.height),
        Offset((x1 + 160) / 2, size.height / 2), mainLinePaint);
  }

  void drawFirstLinePerpendicular(Canvas canvas, Size size) {
    double widthCalcValue = angleSliderValue * 100;
    double x0 = (size.width / 3 - widthCalcValue + 160) / 2;
    double y0 = size.height / 2;
    double xa = size.width / 3 - widthCalcValue;
    double xb = 160;
    double ya = 320;
    double yb = 0;

    double unknownY(double x) {
      double numerator =
          x * xb - xb * x0 - xa * x + xa * x0 - yb * y0 + ya * y0;
      double denominator = ya - yb;
      double unknownY = numerator / denominator;
      return unknownY;
    }

    canvas.drawLine(
        Offset(x0, y0), Offset(10, unknownY(10)), perpendicularLinePaint);

    final double xAngle = 60;
    final angleArc = Path();
    angleArc.moveTo(xAngle, unknownY(xAngle));
    angleArc.arcToPoint(
        Offset(xAngle, unknownY(xAngle) + 44 - angleSliderValue * 19),
        clockwise: false,
        radius: Radius.circular(30));
    final anglePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.yellow;

    canvas.drawPath(angleArc, anglePaint);

    final textPainter = TextPainter(
        text: TextSpan(
            text: '${firstAngleData[angleValue]}°',
            style: TextStyle(color: Colors.yellow, fontSize: 27)),
        textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final offset =
    Offset(xAngle, unknownY(xAngle) + 44 - angleSliderValue * 19);
    textPainter.paint(canvas, offset);

    final perpendicularRectangle = Path();
    perpendicularRectangle.moveTo(x0 - 20, unknownY(x0 - 20));
    perpendicularRectangle.lineTo(
        x0 - 17 + angleSliderValue * 7, 135 - angleSliderValue * 8);
    perpendicularRectangle.lineTo(x0 + 3 + angleSliderValue * 6,
        unknownY(x0 + 10) - 23 - angleSliderValue * 4);
    canvas.drawPath(perpendicularRectangle, perpendicularRectanglePaint);
  }

  void drawMiddleLine(Canvas canvas, Size size) {
    final middleLine = Path();
    double widthCalcValue = angleSliderValue * 100;
    double x1 = size.width / 3 - widthCalcValue;
    double x2 = size.width - size.width / 3 + widthCalcValue;
    middleLine.moveTo((x1 + 160) / 2, size.height / 2);
    middleLine.lineTo((x2 + 160) / 2, size.height / 2 - 10.5);
    canvas.drawPath(middleLine, mainLinePaint);
  }

  //на 50: 270
  //на 30: 50
  //на 20: -60
  void drawThirdLine(Canvas canvas, Size size) {
    final thirdLine = Path();
    double widthCalcValue = angleSliderValue * 100;
    double x1 = size.width - size.width / 3 + widthCalcValue;
    thirdLine.moveTo((x1 + 160) / 2, size.height / 2 - 10.5);
    thirdLine.lineTo(1000, -60 + angleSliderValue * 330);
    canvas.drawPath(thirdLine, mainLinePaint);
  }

  void drawThirdLinePerpendicular(Canvas canvas, Size size) {
    double widthCalcValue = angleSliderValue * 100;
    double x0 = (size.width - size.width / 3 + widthCalcValue + 160) / 2;
    double y0 = size.height / 2 - 10.5;
    double xa = size.width - size.width / 3 + widthCalcValue;
    double xb = 160;
    double ya = 320;
    double yb = 0;

    double unknownY(double x) {
      double numerator =
          x * xb - xb * x0 - xa * x + xa * x0 - yb * y0 + ya * y0;
      double denominator = ya - yb;
      double unknownY = numerator / denominator;
      return unknownY;
    }

    canvas.drawLine(
        Offset(x0, y0), Offset(310, unknownY(310)), perpendicularLinePaint);

    final double xAngle = 265;
    final angleArc = Path();
    angleArc.moveTo(xAngle, unknownY(xAngle));
//    Offset(xAngle, unknownY(xAngle) + 44 - angleSliderValue * 19),
    angleArc.arcToPoint(
        Offset(xAngle, unknownY(xAngle) + 20),
        clockwise: waveValue < 24 ? false : true,
        radius: Radius.circular(30));

//    canvas.drawPath(angleArc, yellowAnglePaint);
    final perpendicularRectangle = Path();
    perpendicularRectangle.moveTo(x0 + 20, unknownY(x0 + 20));
    perpendicularRectangle.lineTo(
        x0 + 16 - 8 * angleSliderValue, 123 - angleSliderValue * 5);
    perpendicularRectangle.lineTo(x0 - 6 - 6 * angleSliderValue,
        unknownY(x0) - 21.5 - angleSliderValue * -1);
    canvas.drawPath(perpendicularRectangle, perpendicularRectanglePaint);

    final textPainter = TextPainter(
        text: TextSpan(
            text: '${secondAngleData[angleValue]}°',
            style: TextStyle(color: Colors.yellow, fontSize: 27)),
        textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final offset = Offset(240, unknownY(205));
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
