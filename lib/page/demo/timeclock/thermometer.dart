import 'dart:math';

import 'package:flutter/material.dart';

class ThermometerPage extends StatefulWidget {
  final double width;
  final double degree;
  final double maxDegree;
  final double minDegree;

  const ThermometerPage(
      {Key key,
        @required this.width,
        this.degree,
        this.maxDegree,
        this.minDegree})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThermometerPageState();
  }
}

class ThermometerPageState extends State<ThermometerPage>
    with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    var controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = animation.value;
        });
      });

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ThermometerPainter(width: widget.width, degree: widget.degree*_fraction),
      size: Size(widget.width, widget.width),
    );
  }
}

class ThermometerPainter extends CustomPainter {
  final double width;
  double degree;
  final double maxDegree;
  final double minDegree;
  double perOfMaxDegree = 0.0;
  List<Offset> calibrations = [];

  ThermometerPainter(
      {this.width,
        this.degree = 0.0,
        this.maxDegree = 100.0,
        this.minDegree = 0.0}) {
    perOfMaxDegree = (degree - minDegree) / (maxDegree - minDegree);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 10;

    final baseCircle = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
//    canvas.drawCircle(Offset(radius, radius), radius, baseCircle);

    final border = Path()
      ..addArc(Rect.fromCircle(center: Offset(radius, radius), radius: radius),
          degToRad(30), degToRad(300));
    final w = cos(degToRad(30)) * radius;
    final h = sin(degToRad(30)) * radius;

    border.addPath(
        Path()
          ..addPolygon(
              [Offset(radius + w, radius - h), Offset(width - h, radius - h)],
              true),
        Offset(0, 0));
    border.addArc(Rect.fromCircle(center: Offset(width - h, radius), radius: h),
        degToRad(-90), degToRad(180));
    border.addPath(
        Path()
          ..addPolygon(
              [Offset(radius + w, radius + h), Offset(width - h, radius + h)],
              true),
        Offset(0, 0));
    canvas.drawPath(border, baseCircle);

    // draw calibration
    final caliTotalWidth = width - h - radius - w;
    final caliWidth = caliTotalWidth / 20;

    for (var i = 0; i < 21; i++) {
      final offset = Offset(radius + w + caliWidth * i, radius - h);
      calibrations.add(offset);
    }
    for (var i = 0; i < calibrations.length; i++) {
      final offset = calibrations[i];
      canvas.drawLine(
          offset,
          Offset(offset.dx, i % 2 == 0 ? offset.dy + h : offset.dy + h / 2),
          baseCircle);
    }

    final innerPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final baseBorder = Path()
      ..addArc(
          Rect.fromCircle(center: Offset(radius, radius), radius: radius - 4),
          degToRad(30),
          degToRad(300));
    canvas.drawPath(baseBorder, innerPaint);

    final ww = cos(degToRad(30)) * (radius - 4);
    final hh = sin(degToRad(30)) * (radius - 4);
    final innerBorder = Path();
    double degreeW = radius + ww + caliTotalWidth * perOfMaxDegree;
    innerBorder.addPath(
        Path()
          ..addPolygon([
            Offset(radius + ww, radius - hh),
            Offset(degreeW, radius - hh),
            Offset(degreeW, radius + hh),
            Offset(radius + ww, radius + hh)
          ], true),
        Offset(0, 0));
    innerBorder.addArc(
        Rect.fromCircle(center: Offset(degreeW, radius), radius: hh),
        degToRad(-90),
        degToRad(180));
//    innerBorder.addPath(
//        Path()
//          ..addPolygon(
//              [Offset(radius + ww, radius + hh), Offset(width - hh, radius + hh)],
//              true),
//        Offset(0, 0));

    canvas.drawPath(innerBorder, innerPaint);

    final lightw = cos(degToRad(30)) * (radius - 10);
    final lighth = sin(degToRad(30)) * (radius - 10);
    final lightPath = Path();
    final lightPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    lightPath
      ..addArc(
          Rect.fromCircle(center: Offset(radius, radius), radius: radius - 10),
          degToRad(-120),
          degToRad(90));
    lightPath.addPath(
        Path()
          ..addPolygon([
            Offset(radius + lightw, radius - lighth + 1),
            Offset(degreeW - 8, radius - lighth + 1)
          ], true),
        Offset(0, 0));
    lightPath.addArc(
        Rect.fromCircle(center: Offset(degreeW - 8, radius), radius: lighth),
        degToRad(-90),
        degToRad(60));
    canvas.drawPath(lightPath, lightPaint);
  }

  @override
  bool shouldRepaint(ThermometerPainter oldDelegate) {
    return oldDelegate.degree != degree;
  }
}

num degToRad(num deg) => deg * (pi / 180.0);