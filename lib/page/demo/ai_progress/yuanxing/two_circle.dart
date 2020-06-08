import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

///restore() 合并
///save() 操作会保存此前的所有绘制内容和 Canvas状态(坐标)。
///saveLayer() 会创建一个新的图层

//画进度条
class TwoCircle extends StatefulWidget {
  //环形底部颜色
  //环形进度颜色
  //画笔宽度
  //进度值
  final Color backgroundColor;
  final Color progressColor;

  final double paintWidth;
  final double progress;

  TwoCircle(
      this.backgroundColor, this.progressColor, this.paintWidth, this.progress);

  @override
  _TwoCircleState createState() => _TwoCircleState();
}

class _TwoCircleState extends State<TwoCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(200, 200),
          painter: C._(widget.backgroundColor, widget.progressColor,
              widget.paintWidth, widget.progress, true, false),
        ),
      ),
    );
  }
}

class C extends CustomPainter {
  final Color backgroundColor;
  final Color progressColor;

  final double paintWidth;
  final double progress;
  bool _shouldRepaint;

  ///判断是否和中心点连接
  bool _useCenter;

  Size size;

  double radius = 0;

  var _valuePaint = Paint();

  C._(this.backgroundColor, this.progressColor, this.paintWidth, this.progress,
      this._shouldRepaint, this._useCenter);


  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    this.size = size;
    _setPaint();
    Rect rect = Offset.zero & size;

    radius = size.width/2;
    var of = Offset(radius, radius);
    //画圆
    canvas.drawCircle(of, radius, _valuePaint);

    _valuePaint
      ..color = progressColor
      ..strokeWidth = _valuePaint.strokeWidth - 6;

    canvas.drawArc(
        rect, -pi / 2, (2 * pi) / 100 * progress, _useCenter, _valuePaint);

    _valuePaint
      ..color = Colors.yellow
      ..strokeWidth = 5;

    //画刻度
    canvas.translate(radius, radius);

    ///旋转的是坐标而不是画布
    ///旋转是以中心点旋转
    ///画12个大点
    ///画60个小点

    List.generate(60, (i) {
      if (i % 5 == 0) {
        //大点
        canvas.drawLine(Offset(0, -radius),
            Offset(0, -radius + 10), _valuePaint);

      } else {
        //小点
        canvas.drawLine(Offset(0, -radius),
            Offset(0, -radius + 5), _valuePaint);
      }
      canvas.rotate(pi / 30);
    });

    //先还原再保存  还原的是绘制状态
    canvas.restore();
    canvas.save();
    canvas.translate(radius, radius);
    List.generate(12, (i){
      canvas.rotate(pi / 6);
      drawText(canvas, -5, -size.width / 2+20,"${(i+1).toInt()}");
    });

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return _shouldRepaint;
  }



  drawText(canvas, double x, double y,String text) {
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      fontSize: 15.0,
    ));
    pb.pushStyle(ui.TextStyle(color: Colors.black));
    pb.addText(text);
    // 设置文本的宽度约束
    ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: 30);
    // 这里需要先layout,将宽度约束填入，否则无法绘制
    ui.Paragraph paragraph = pb.build()..layout(pc);
    // 文字左上角起始点of.dx + 10, of.dy + 50
    Offset offset = Offset(x, y);
    canvas.drawParagraph(paragraph, offset);
  }

  _setPaint() {
    return _valuePaint
      ..color = backgroundColor
      ..strokeWidth = paintWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..style = PaintingStyle.stroke;
  }
}
