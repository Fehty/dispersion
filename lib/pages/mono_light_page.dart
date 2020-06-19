import 'package:dispersion/constants.dart';
import 'package:dispersion/locale/app_localization.dart';
import 'package:dispersion/pages/root_page.dart';
import 'package:dispersion/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class MonoLightPage extends StatefulWidget {
  MonoLightPage({Key key}) : super(key: key);

  @override
  _MonoLightPageState createState() => _MonoLightPageState();
}

class _MonoLightPageState extends State<MonoLightPage> {
  double _waveSliderValue = 0.0;
  int _waveValue = 380;

  double _angleSliderValue = 0.0;
  int _angleValue = 20;

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
                title: Text(AppLocalization.of(context).fullMonoLight))),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          physics: BouncingScrollPhysics(),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height < 600
                  ? 590
                  : MediaQuery.of(context).size.height - 90,
              child: Column(children: [
//                Align(
//                    alignment: Alignment.topLeft,
//                    child: Padding(
//                        padding: const EdgeInsets.only(left: 16, top: 54),
//                        child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              GradientText('Монохромное',
//                                  gradient: mainGradient,
//                                  textStyle:
//                                      Theme.of(context).textTheme.headline4),
//                              GradientText('излучение',
//                                  gradient: mainGradient,
//                                  textStyle:
//                                      Theme.of(context).textTheme.headline4)
//                            ])
//                    )),
                SizedBox(
                    height: MediaQuery.of(context).size.height < 600 ? 60 : 80),
                SizedBox(
                    width: 320,
                    height: 320,
                    child: CustomPaint(
                        painter: MyPainter(_angleSliderValue, _angleValue,
                            _waveSliderValue, _waveValue))),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.only(left: 17, bottom: 6),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GradientText('n',
                                gradient: mainGradient,
                                textStyle:
                                    Theme.of(context).textTheme.headline4),
//                              GradientText('стекла',
//                                  gradient: mainGradient,
//                                  textStyle:
//                                  Theme.of(context).textTheme.bodyText1),
                            GradientText(' = 1.63',
                                gradient: mainGradient,
                                textStyle:
                                    Theme.of(context).textTheme.headline4),
                          ],
                        ))),
                Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(children: [
                      GradientText('α = $_angleValue°',
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
                                      value: _angleSliderValue,
                                      activeColor: Colors.white,
                                      inactiveColor:
                                          Color.fromRGBO(138, 171, 193, 0.4),
                                      onChanged: (double value) {
                                        setState(() {
                                          _angleSliderValue = value;
                                          _angleValue =
                                              (_angleSliderValue * 30 + 20)
                                                  .toInt();
                                        });
                                      }))))
                    ])),
                Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GradientText('λ = $_waveValue',
                              gradient: mainGradient,
                              textStyle: Theme.of(context).textTheme.headline4),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: GradientText(
                                  ' ${AppLocalization
                                      .of(context)
                                      .nm}',
                                  gradient: mainGradient,
                                  textStyle:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .headline5)),
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
                                          value: _waveSliderValue,
                                          activeColor: Colors.white,
                                          inactiveColor: Color.fromRGBO(
                                              138, 171, 193, 0.4),
                                          onChanged: (double value) {
                                            setState(() {
                                              _waveSliderValue = value;
                                              _waveValue =
                                                  (380 * _waveSliderValue + 380)
                                                      .toInt();
                                            });
                                          }))))
                        ])),
                SizedBox(height: 12)
              ])),
        ));
  }
}

class MyPainter extends CustomPainter {
  final angleSliderValue;
  final angleValue;

  final waveSliderValue;
  final waveValue;

  MyPainter(this.angleSliderValue, this.angleValue, this.waveSliderValue,
      this.waveValue);

  final _mainLinePaint = Paint();
  final _perpendicularLinePaint = Paint();
  final _yellowAnglePaint = Paint();
  final _perpendicularRectanglePaint = Paint();

  double _firstWidthCalc;
  double _secondWidthCalc;

  @override
  void paint(Canvas canvas, Size size) {
    if (newAppEnter.value) {
      innerDrawerKey.currentState.open();
      Future.delayed(Duration(milliseconds: 1200))
          .then((value) => newAppEnter.value = false);
    }

    _mainLinePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = waveValue > 625 || waveValue == 625
          ? Colors.red
          : waveValue < 625 && waveValue > 590 || waveValue == 590
          ? Colors.orange
          : waveValue < 590 && waveValue > 565 || waveValue == 565
          ? Colors.yellow
          : waveValue < 565 && waveValue > 540 || waveValue == 540
          ? Colors.lightGreen
          : waveValue < 540 && waveValue > 500 || waveValue == 500
          ? Colors.green
          : waveValue < 500 && waveValue > 485 ||
          waveValue == 485
          ? Colors.blue
          : waveValue < 485 && waveValue > 440 ||
          waveValue == 440
          ? Color.fromRGBO(0, 0, 240, 1)
          : waveValue < 440 && waveValue > 380 ||
          waveValue == 380
          ? Color.fromRGBO(102, 0, 204, 1)
          : Colors.blue;
    _perpendicularLinePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white;
    _yellowAnglePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.yellow;
    _perpendicularRectanglePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white;

    _firstWidthCalc = angleSliderValue * 106;
    _secondWidthCalc = angleSliderValue * 100;
    drawTriangle(canvas, size);
    drawAngle(canvas, size);
    drawFirstLine(canvas, size);
    drawFirstLinePerpendicular(canvas, size);
    drawMiddleLine(canvas, size);
    drawThirdLine(canvas, size);
    drawThirdLinePerpendicular(canvas, size);
  }

  void drawTriangle(Canvas canvas, Size size) {
//    double widthCalcValue = 38;
//    double widthCalcValue = angleSliderValue * 106;
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final trianglePaint = Paint()
      ..shader = mainGradient.createShader(rect);
    var trianglePath = Path();
    trianglePath.moveTo(size.width / 2, 0);
    //37
    trianglePath.lineTo(size.width / 3 - _firstWidthCalc, size.height);
    trianglePath.lineTo(
        size.width - size.width / 3 + _firstWidthCalc, size.height);
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
//    double widthCalcValue = angleSliderValue * 100;
    double x1 = size.width / 3 - _secondWidthCalc;

    canvas.drawLine(Offset(-250, size.height),
        Offset((x1 + 160) / 2, size.height / 2), _mainLinePaint);
  }

  void drawFirstLinePerpendicular(Canvas canvas, Size size) {
//    double widthCalcValue = angleSliderValue * 100;
    double x0 = (size.width / 3 - _secondWidthCalc + 160) / 2;
    double y0 = size.height / 2;
    double xa = size.width / 3 - _secondWidthCalc;
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
        Offset(x0, y0), Offset(10, unknownY(10)), _perpendicularLinePaint);

    final double xAngle = 60;
    final angleArc = Path();
    angleArc.moveTo(xAngle, unknownY(xAngle));
    angleArc.arcToPoint(
        Offset(
            xAngle,
            linearEquationGetY(
                LinearPoints(-250, size.height, x0, y0), xAngle)),
//        Offset(xAngle, unknownY(xAngle) + 44 - angleSliderValue * 19),
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
    canvas.drawPath(perpendicularRectangle, _perpendicularRectanglePaint);
  }

  void drawMiddleLine(Canvas canvas, Size size) {
    final middleLine = Path();
//    double widthCalcValue = angleSliderValue * 100;
    double x1 = size.width / 3 - _secondWidthCalc;
    double x2 = size.width - size.width / 3 + _secondWidthCalc;
    middleLine.moveTo((x1 + 160) / 2, size.height / 2);
    middleLine.lineTo((x2 + 160) / 2, size.height / 2 - 10.5);
    canvas.drawPath(middleLine, _mainLinePaint);
  }

  void drawThirdLine(Canvas canvas, Size size) {
    final thirdLine = Path();
//    double widthCalcValue = angleSliderValue * 100;
    double x1 = size.width - size.width / 3 + _secondWidthCalc;
    thirdLine.moveTo((x1 + 160) / 2, size.height / 2 - 10.5);
    thirdLine.lineTo(
        1000,
        angleSliderValue * 330 -
            115 -
            angleSliderValue * 100 +
            100 +
            25 -
            waveSliderValue * 25);
//    thirdLine.lineTo(
//        1000,
//       200);
//               -80 + angleSliderValue * 330 + 25 - waveSliderValue * 25);
    canvas.drawPath(thirdLine, _mainLinePaint);
  }

  void drawThirdLinePerpendicular(Canvas canvas, Size size) {
//    double widthCalcValue = angleSliderValue * 100;
    double x0 = (size.width - size.width / 3 + _secondWidthCalc + 160) / 2;
    double y0 = size.height / 2 - 10.5;
    double xa = size.width - size.width / 3 + _secondWidthCalc;
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
        Offset(x0, y0), Offset(310, unknownY(310)), _perpendicularLinePaint);

    double secondAngle = (1.63 * angleValue - firstAngleData[angleValue]) +
        (0.60 + 0.90 * angleSliderValue) * (1 - waveSliderValue);

    final double xAngle = 270;
    final angleArc = Path();
    double x1 = size.width - size.width / 3 + _secondWidthCalc;
    angleArc.moveTo(xAngle, unknownY(xAngle));
    angleArc.arcToPoint(
        Offset(
            xAngle,
            linearEquationGetY(
                LinearPoints(
                    (x1 + 160) / 2,
                    size.height / 2 - 10.5,
                    1000,
                    angleSliderValue * 330 -
                        115 -
                        angleSliderValue * 100 +
                        100 +
                        25 -
                        waveSliderValue * 25),
                xAngle)),
        clockwise: true,
        radius: Radius.circular(20));
    if (secondAngle > 0.0) canvas.drawPath(angleArc, _yellowAnglePaint);
    final perpendicularRectangle = Path();
    perpendicularRectangle.moveTo(x0 + 20, unknownY(x0 + 20));
    perpendicularRectangle.lineTo(
        x0 + 16 - 8 * angleSliderValue, 123 - angleSliderValue * 5);
    perpendicularRectangle.lineTo(x0 - 6 - 6 * angleSliderValue,
        unknownY(x0) - 21.5 - angleSliderValue * -1);
    canvas.drawPath(perpendicularRectangle, _perpendicularRectanglePaint);

//    double secondAngle = secondAngleData[angleValue];
//    double secondAngle = (1.63 * angleValue - firstAngleData[angleValue]) + 1.5 - waveSliderValue*1.5 - (50 - angleValue);
//    double secondAngle = 1.5 - waveSliderValue * 1.5 - (50 - angleValue);

    final textPainter = TextPainter(
        text: TextSpan(
            text: '${secondAngle.toStringAsFixed(2)}°',
            style: TextStyle(color: Colors.yellow, fontSize: 27)),
        textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final offset = Offset(240, unknownY(205));
    textPainter.paint(canvas, offset);
  }

  double linearEquationGetY(LinearPoints points, double x) {
    final double x1 = points.x1;
    final double y1 = points.y1;
    final double x2 = points.x2;
    final double y2 = points.y2;

    final double numerator = -(x1 * y2 - x2 * y1) - (y1 - y2) * x;
    final double denominator = (x2 - x1);
    final y = numerator / denominator;

    return y;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LinearPoints {
  final double x1;
  final double y1;
  final double x2;
  final double y2;

  const LinearPoints(this.x1, this.y1, this.x2, this.y2);
}
