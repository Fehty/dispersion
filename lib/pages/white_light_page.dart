import 'package:dispersion/constants.dart';
import 'package:dispersion/locale/app_localization.dart';
import 'package:dispersion/pages/root_page.dart';
import 'package:dispersion/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class WhiteLightPage extends StatefulWidget {
  WhiteLightPage({Key key}) : super(key: key);

  @override
  _WhiteLightPageState createState() => _WhiteLightPageState();
}

class _WhiteLightPageState extends State<WhiteLightPage> {
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
                title: Text(AppLocalization.of(context).fullWhiteLight))),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height < 500
                    ? 500
                    : MediaQuery.of(context).size.height - 90,
                child: Column(children: [
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height < 600 ? 60 : 135),
                  SizedBox(
                      width: 320,
                      height: 320,
                      child: CustomPaint(
                          painter: MyPainter(_angleSliderValue, _angleValue))),
                  Spacer(),
                  Align(
                      alignment: Alignment.center,
                      child: GradientText('α = $_angleValue°',
                          gradient: mainGradient,
                          textStyle: Theme.of(context).textTheme.headline4)),
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
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
                                      }))))),
                  SizedBox(height: 6)
                ]))));
  }
}

class MyPainter extends CustomPainter {
  final angleSliderValue;
  final angleValue;

  MyPainter(this.angleSliderValue, this.angleValue);

  final _firstLinePaint = Paint();
  final _perpendicularLinePaint = Paint();
  final _yellowAnglePaint = Paint();
  final _perpendicularRectanglePaint = Paint();

  double _firstWidthCalc;
  double _secondWidthCalc;

  @override
  void paint(Canvas canvas, Size size) {
    _firstLinePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white;
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
      ..strokeWidth = 3
      ..color = Colors.white;

    _firstWidthCalc = angleSliderValue * 106;
    _secondWidthCalc = angleSliderValue * 100;

    drawTriangle(canvas, size);
    drawAngle(canvas, size);
    drawFirstLine(canvas, size);
    drawFirstLineArrow(canvas, size);
    drawFirstLinePerpendicular(canvas, size);
    drawMiddleLine(canvas, size);
    drawThirdLine(canvas, size);
  }

  void drawTriangle(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final trianglePaint = Paint()
      ..shader = mainGradient.createShader(rect);
    var trianglePath = Path();
    trianglePath.moveTo(size.width / 2, 0);
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
    double x1 = size.width / 3 - _secondWidthCalc;

    canvas.drawLine(Offset(-250, size.height),
        Offset((x1 + 160) / 2, size.height / 2), _firstLinePaint);
  }

  void drawFirstLinePerpendicular(Canvas canvas, Size size) {
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

  void drawFirstLineArrow(Canvas canvas, Size size) {
    final arrowPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..color = Colors.white;

    double x0 = (size.width / 3 - _secondWidthCalc + 160) / 2;
    double y0 = size.height / 2;

    final arrowPath1 = Path();
    arrowPath1.moveTo(
        -90, linearEquationGetY(LinearPoints(-250, size.height, x0, y0), -90));
    arrowPath1.lineTo(-130,
        linearEquationGetY(LinearPoints(-250, size.height, x0, y0), -130) - 10);
    arrowPath1.lineTo(-115,
        linearEquationGetY(LinearPoints(-250, size.height, x0, y0), -115));
    arrowPath1.lineTo(-121,
        linearEquationGetY(LinearPoints(-250, size.height, x0, y0), -121) + 10);
    canvas.drawPath(arrowPath1, arrowPaint);

    final arrowPath2 = Path();
    arrowPath2.moveTo(
        30, linearEquationGetY(LinearPoints(-250, size.height, x0, y0), 30));
    arrowPath2.lineTo(-10,
        linearEquationGetY(LinearPoints(-250, size.height, x0, y0), -10) - 10);
    arrowPath2.lineTo(
        7, linearEquationGetY(LinearPoints(-250, size.height, x0, y0), 7));
    arrowPath2.lineTo(0,
        linearEquationGetY(LinearPoints(-250, size.height, x0, y0), -4) + 10);
    canvas.drawPath(arrowPath2, arrowPaint);
  }

  double linearEquationGetX(LinearPoints points, double y) {
    final double x1 = points.x1;
    final double y1 = points.y1;
    final double x2 = points.x2;
    final double y2 = points.y2;

    final double numerator = -(x2 - x1) * y - (x1 * y2 - x2 * y1);
    final double denominator = (y1 - y2);
    final x = numerator / denominator;

    return x;
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

  void drawMiddleLine(Canvas canvas, Size size) {
    final middleLine1 = Path();
    final secondLinePaint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..color = Colors.purple;
    double x1 = size.width / 3 - _secondWidthCalc;
    double x2 = size.width - size.width / 3 + _secondWidthCalc - 5;
    middleLine1.moveTo((x1 + 160) / 2, size.height / 2);
    middleLine1.lineTo(
        (x2 + 160) / 2 - angleSliderValue * 2, size.height / 2 - 17);
    canvas.drawPath(middleLine1, secondLinePaint1);

    final middleLine2 = Path();
    final secondLinePaint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..color = Colors.red;
    middleLine2.moveTo((x1 + 160) / 2, size.height / 2);
    middleLine2.lineTo(
        (x2 + 160) / 2 - angleSliderValue * 2, size.height / 2 - 16.5);
    canvas.drawPath(middleLine2, secondLinePaint2);

    final middleLine3 = Path();
    final secondLinePaint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..color = Colors.orange;
    middleLine3.moveTo((x1 + 160) / 2, size.height / 2);
    middleLine3.lineTo(
        (x2 + 160) / 2 - angleSliderValue * 2, size.height / 2 - 16);
    canvas.drawPath(middleLine3, secondLinePaint3);
  }

  void drawThirdLine(Canvas canvas, Size size) {
    double x2 = size.width - size.width / 3 + _secondWidthCalc;

    final redLine = Path();
    final redPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.red;
    redLine.moveTo(
        (x2 + 160) / 2 - 3 - angleSliderValue * 2, size.height / 2 - 16.5);
    redLine.lineTo(1000, angleSliderValue * 330 - 110);
    redLine.lineTo(1000, angleSliderValue * 330 - 80);
    canvas.drawPath(redLine, redPaint);

    final orangeLine = Path();
    final orangePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.orange;
    orangeLine.moveTo(
        (x2 + 160) / 2 - 3 - angleSliderValue * 2, size.height / 2 - 16.5);
    orangeLine.lineTo(1000, angleSliderValue * 330 - 82);
    orangeLine.lineTo(1000, angleSliderValue * 330 - 60);
    canvas.drawPath(orangeLine, orangePaint);

    final yellowLine = Path();
    final yellowPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.yellow;
    yellowLine.moveTo(
        (x2 + 160) / 2 - 3 - angleSliderValue * 2, size.height / 2 - 16.5);
    yellowLine.lineTo(1000, angleSliderValue * 330 - 62);
    yellowLine.lineTo(1000, angleSliderValue * 330 - 40);
    canvas.drawPath(yellowLine, yellowPaint);

    final lightGreenLine = Path();
    final lightGreenPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.lightGreen;
    lightGreenLine.moveTo(
        (x2 + 160) / 2 - 3 - angleSliderValue * 2, size.height / 2 - 16.5);
    lightGreenLine.lineTo(1000, angleSliderValue * 330 - 42);
    lightGreenLine.lineTo(1000, angleSliderValue * 330 - 30);
    canvas.drawPath(lightGreenLine, lightGreenPaint);

    final greenLine = Path();
    final greenPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.green;
    greenLine.moveTo(
        (x2 + 160) / 2 - 3 - angleSliderValue * 2, size.height / 2 - 16.5);
    greenLine.lineTo(1000, angleSliderValue * 330 - 32);
    greenLine.lineTo(1000, angleSliderValue * 330 - 20);
    canvas.drawPath(greenLine, greenPaint);

    final blueLine = Path();
    final bluePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Colors.blue;
    blueLine.moveTo(
        (x2 + 160) / 2 - 3 - angleSliderValue * 2, size.height / 2 - 16.5);
    blueLine.lineTo(1000, angleSliderValue * 330 - 22);
    blueLine.lineTo(1000, angleSliderValue * 330 - 0);
    canvas.drawPath(blueLine, bluePaint);

    final deepBlueLine = Path();
    final deepBluePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Color.fromRGBO(0, 0, 240, 1);
    deepBlueLine.moveTo(
        (x2 + 160) / 2 - 3 - angleSliderValue * 2, size.height / 2 - 16.5);
    deepBlueLine.lineTo(1000, angleSliderValue * 330 - 2);
    deepBlueLine.lineTo(1000, angleSliderValue * 330 + 20);
    canvas.drawPath(deepBlueLine, deepBluePaint);

    final purpleLine = Path();
    final purplePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
      ..color = Color.fromRGBO(102, 0, 204, 1);
    purpleLine.moveTo(
        (x2 + 160) / 2 - 3 - angleSliderValue * 2, size.height / 2 - 16.5);
    purpleLine.lineTo(1000, angleSliderValue * 330 + 22);
    purpleLine.lineTo(1000, angleSliderValue * 330 + 60);
    canvas.drawPath(purpleLine, purplePaint);
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
