import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterjdshop/common/common.dart';

class PathPainterStudy extends CustomPainter {
  Paint paint2 = Paint();
  Path path = Path();
  Path path2 = Path();
  Path path3 = Path();

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    paint2
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..color = Colors.red;

    ///addXXX() - 添加子图形
    ///XXXTo() - 画线（直线或曲线）
    path.addArc(new Rect.fromLTWH(50, 50, 50, 50), 135.0 * (PI / DEGREE), 225.0 * (PI / DEGREE));
    path.addArc(new Rect.fromLTWH(100, 50, 50, 50), 180.0 * (PI / DEGREE), 225.0 * (PI / DEGREE));
    path.lineTo(100, 140);
    path.lineTo(58, 93);

    canvas.drawPath(path, paint2);

    paint2 ..color = Colors.blue..strokeWidth= 10;

    path2.moveTo(100, 100);
    path2.relativeLineTo(30,20);

    path2.moveTo(0, 100);
    ///x1 y1 是控制点位置   x2 y2 结束点位置
    path2.quadraticBezierTo(100, 50, 200, 100);
    ///forceMoveTo true抬起笔(moveTo)，false不抬起笔
    path2.arcTo(Rect.fromLTWH(220, 110, 50, 50), 0* (PI / DEGREE), 90* (PI / DEGREE), true);

    path2.arcTo(Rect.fromLTWH(100, 150, 50, 50), 0* (PI / DEGREE), 90* (PI / DEGREE), false);
    path2.close();
    canvas.drawPath(path2, paint2);

    List<Offset> points = new List();
    points.add(new Offset(100, 50)); // 画出控制点位置，方便理解
    canvas.drawPoints(PointMode.points, points, paint2);
    ///画弧线 - arcTo(Rect rect, double startAngle, double sweepAngle, bool forceMoveTo)

  }

  ///尽可能的利用好shouldRepaint返回值；在UI树重新build时，
  ///控件在绘制前都会先调用该方法以确定是否有必要重绘；
  ///假如我们绘制的UI不依赖外部状态，那么就应该始终返回false，
  ///因为外部状态改变导致重新build时不会影响我们的UI外观；
  ///如果绘制依赖外部状态，那么我们就应该在shouldRepaint中判断依赖的状态是否改变，如果已改变则应返回true来重绘，反之则应返回false不需要重绘。
  ///返回false不会重绘，返回true就会重绘，可以根据外部状态来处理返回值
  ///如果不变的Widget就单独抽出来一个Widget返回false
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
