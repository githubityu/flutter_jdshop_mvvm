import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutterjdshop/bean/option_bean.dart';

//传入颜色和值来画饼形状
class OneCircle extends StatefulWidget {
  //饼状的颜色
  final List<Color> colors;
  final int index;

  //饼状的值
  final List<double> values;

  OneCircle({Key key, this.colors, this.values, this.index: -1})
      : super(key: key) {
    ///两个值数量一定要一致
    assert(colors.length == values.length);
  }

  @override
  _OneCircleState createState() => _OneCircleState();
}

class _OneCircleState extends State<OneCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(100, 100),
          painter: B._(widget.colors, widget.values, true, true, widget.index),
        ),
      ),
    );
  }
}

class B extends CustomPainter {
  //饼状的颜色
  final List<Color> colors;

  //饼状的值
  final List<double> values;
  bool _shouldRepaint;

  final int index;

  ///判断是否和中心点连接
  bool _useCenter;

  Size size;

  var _valuePaint = Paint();

  B._(this.colors, this.values, this._shouldRepaint, this._useCenter,
      this.index);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    this.size = size;
    _setPaint();
    var of = Offset.zero & size;
    if (index == -1) {
      _getSweepAngle.map((d) {
        _valuePaint..color = d.third;
        canvas.drawArc(of, d.first, d.second, _useCenter, _valuePaint);
      }).toList();
    } else {
      //新创建一个图层
       _getSweepAngle.sublist(0,index).map((d){
         _valuePaint..color = d.third;
         canvas.drawArc(of, d.first, d.second, _useCenter, _valuePaint);
       }).toList();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return _shouldRepaint;
  }

  _setPaint() {
    return _valuePaint
      ..color = Colors.grey
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..style = PaintingStyle.fill;
  }

  /// 算出弧度大小

  List<OptionBean> get _getSweepAngle {
    double small = pi * 2 / getCount;
    double startNum = 0;
    List<OptionBean> ops = [];
    List.generate(values.length, (index) {
      var op = OptionBean(first: startNum);
      //设置画笔颜色和值
      //360
      op.second = values[index] * small;
      startNum += op.second;
      op.third = colors[index];
      ops.add(op);
    });
    return ops;
  }

  double get getCount => values.reduce((x1, x2) => x1 + x2);
}
