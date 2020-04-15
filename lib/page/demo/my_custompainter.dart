import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MyCustomPainter extends CustomPainter {
  ///Canvas：一个画布，包括各种绘制方法
  ///|drawLine | 画线 | 实线 虚线
  ///| drawPoint | 画点 |
  ///| drawPath | 画路径 |
  ///| drawImage | 画图像 |
  ///| drawRect | 画矩形 |
  ///| drawCircle | 画圆 |
  ///| drawOval | 画椭圆 |
  /// | drawArc | 画圆弧 |
  ///Size：当前绘制区域大小

  Paint paint2 = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    double gap = size.width / 15;
    //设置画笔颜色
    paint2
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.red;
    ///画背景
    ///也可以用drawColor
    canvas.drawRect(Offset.zero & size, paint2);

    paint2
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 15; i++) {
      var dy = gap * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint2);
    }

    for (int i = 0; i < 15; i++) {
      var dx = gap * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.width), paint2);
    }

    paint2
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 2 + gap / 2, size.width / 2 + gap / 2),
        gap / 2,
        paint2);

    paint2
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(
        Offset(size.width / 2 - gap / 2, size.width / 2 - gap / 2),
        gap / 2,
        paint2);

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
