import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MyCustomPainter2 extends CustomPainter {
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
  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    //用的较少
    ///canvas.drawColor(Colors.blue, BlendMode.srcIn);
    double gap = size.width / 15;
    paint2
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..isAntiAlias = true;

    canvas.drawRect(Offset.zero & size, paint2);

    ///StrokeCap
    ///round 圆角直线
    ///butt 直角直线但是长度会比真实长度短1/2的strokeWidth
    ///square正常的直线
    paint2
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    //画一个实线
    canvas.drawLine(Offset(10, gap), Offset(50, gap), paint2);
    paint2..strokeCap = StrokeCap.butt;
    canvas.drawLine(Offset(10, gap * 2), Offset(50, gap * 2), paint2);
    paint2..strokeCap = StrokeCap.square;
    canvas.drawLine(Offset(10, gap * 3), Offset(50, gap * 3), paint2);
    //画一个圆点
    paint2
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    ///PointMode
    ///lines 两个点直接画直线 不是成对的 最后一个舍弃
    ///points 普通的点，StrokeCap 可以设置是圆点还是正方形点
    ///polygon 相近的两个点相连 多边形
    canvas.drawPoints(
        ui.PointMode.lines,
        [
          Offset(gap * 1, gap * 4),
          Offset(gap * 2, gap * 4),
          Offset(gap * 3, gap * 4),
          Offset(gap * 5, gap * 4),
        ],
        paint2);
//    paint2
//      ..style = PaintingStyle.fill
//      ..color = Colors.red;
//
//    canvas.drawPoints(
//        PointMode.points,
//        [
//          Offset(gap * 3 + 5, gap * 3 + 5),
//          Offset(gap * 4, gap * 4),
//          Offset(gap * 5, gap * 5),
//        ],
//        paint2);
    paint2
      ..style = PaintingStyle.fill
      ..color = Colors.yellow;
    canvas.drawPoints(
        ui.PointMode.polygon,
        [
          Offset(gap, gap * 6),
          Offset(gap * 2, gap * 6),
          Offset(gap * 3, gap * 8),
          Offset(gap * 2, gap * 8),
          Offset(gap, gap * 6),
        ],
        paint2);

    ///绘制圆形
    canvas.drawCircle(Offset(gap, gap * 9), gap / 2, paint2);
    //半径==中心点-画笔的一半宽度
    paint2..style = PaintingStyle.stroke..strokeWidth = gap/4;
    canvas.drawCircle(Offset(gap, gap * 11), gap / 2, paint2);

    ///绘制椭圆
    ///给出一个矩形，然后内切出来一个椭圆
    ///可以画圆形

    ///Rect
    ///fromPoints(Offset a, Offset b) 内部调用fromLTRB
    ///使用左上和右下角坐标来确定矩形的大小和位置 内切
    ///fromCircle({ Offset center, double radius }) fromCircle->fromCenter->fromLTRB
    ///使用圆的圆心点坐标和半经和确定外切矩形的大小和位置
    ///fromLTRB(double left, double top, double right, double bottom)
    ///使用矩形左边的X坐标、矩形顶部的Y坐标、矩形右边的X坐标、矩形底部的Y坐标来确定矩形的大小和位置
    ///fromLTWH(double left, double top, double width, double height)  fromLTRB
    ///使用矩形左边的X坐标、矩形顶部的Y坐标矩形的宽高来确定矩形的大小和位置
    ///终极方法都是fromLTRB来实现的
    var rect =
        Rect.fromPoints(Offset(gap, gap * 12), Offset(gap * 2, gap * 14));
    canvas.drawOval(rect, paint2);

    var rect2 = Rect.fromCircle(center: Offset(gap * 3, gap), radius: 30);

    /// 360°==2π  π=3.1415926
    ///startAngle
    ///中心水平右侧为0
    ///sweepAngle  弧度大小
    ///useCenter 是否和中心连一起  PaintingStyle.fill 可以填充
    /// ..strokeJoin = StrokeJoin.round
    paint2
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 5;
    canvas.drawArc(rect2, 0.1, 0.8, false, paint2);

    paint2
      ..style = PaintingStyle.stroke
      ..color = Colors.white;

    canvas.drawLine(Offset(gap * 5, 0), Offset(gap * 5, size.width), paint2);

    ///下面学习path
    var of = Offset(gap * 5, gap);

    paint2..style = PaintingStyle.fill;

    var rr = RRect.fromLTRBAndCorners(
        of.dx + 10, of.dy + 10, of.dx + 80, of.dy + 30,
        topLeft: Radius.circular(10));

    canvas.drawRRect(rr, paint2);
    var rr2 = RRect.fromLTRBR(of.dx + 10, of.dy + 50, of.dx + 80, of.dy + 80,
        Radius.elliptical(10, 20));

    canvas.drawRRect(rr2, paint2);

    var rr3 = RRect.fromLTRBR(
        of.dx + 100, of.dy + 10, of.dx + 180, of.dy + 30, Radius.circular(10));

    canvas.drawRRect(rr3, paint2);

    ///画矩形环形
    var rr4 = RRect.fromLTRBR(
        of.dx + 100, of.dy + 50, of.dx + 180, of.dy + 100, Radius.circular(5));

    var rr5 = RRect.fromLTRBR(
        of.dx + 110, of.dy + 60, of.dx + 170, of.dy + 90, Radius.circular(5));

    canvas.drawDRRect(rr4, rr5, paint2);

    ///画文字
    List.generate(2, (i) {
      // 新建一个段落建造器，然后将文字基本信息填入;
      ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
        fontSize: 15.0 + i,
      ));
      pb.pushStyle(ui.TextStyle(color: Colors.white));
      pb.addText('有美女卖没有呢 AaBb 68');
      // 设置文本的宽度约束
      ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: 300);
      // 这里需要先layout,将宽度约束填入，否则无法绘制
      ui.Paragraph paragraph = pb.build()..layout(pc);
      // 文字左上角起始点of.dx + 10, of.dy + 50
      Offset offset = Offset(of.dx + 10, of.dy + 100 + i * 40.0);
      canvas.drawParagraph(paragraph, offset);
    });
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
