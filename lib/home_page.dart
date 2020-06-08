import 'package:dispersion/utils.dart';
import 'package:dispersion/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double waveSliderValue = 0.0;
  int waveValue = 350;

  double angleSliderValue = 0.0;
  int angleValue = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height < 500
                    ? 700
                    : MediaQuery.of(context).size.height,
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
                      child: CustomPaint(painter: MyPainter(angleSliderValue))),
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
                ]))));
  }
}

class MyPainter extends CustomPainter {
  final sliderValue;

  MyPainter(this.sliderValue);

  @override
  void paint(Canvas canvas, Size size) {
    drawTriangle(canvas, size);
    drawAngle(canvas, size);
    drawFirstLine(canvas, size);
    drawFirstPerpendicular(canvas, size);
  }

  void drawTriangle(Canvas canvas, Size size) {
    double widthCalcValue = sliderValue * 106;
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
    double widthCalcValue = sliderValue * 100;
    double x1 = size.width / 3 - widthCalcValue;
    final firstLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.red;
    canvas.drawLine(Offset(-250, size.height),
        Offset((x1 + 160) / 2, size.height / 2), firstLinePaint);
  }

  void drawFirstPerpendicular(Canvas canvas, Size size) {
    final firstLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;

    double widthCalcValue = sliderValue * 100;
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

    canvas.drawLine(Offset(x0, y0), Offset(10, unknownY(10)), firstLinePaint);

    final double xAngle = 60;
    final angleArc = Path();
    angleArc.moveTo(xAngle, unknownY(xAngle));
    angleArc.arcToPoint(
        Offset(xAngle, unknownY(xAngle) + 44 - sliderValue * 19),
        clockwise: false,
        radius: Radius.circular(30));
    final anglePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.yellow;

    canvas.drawPath(angleArc, anglePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
