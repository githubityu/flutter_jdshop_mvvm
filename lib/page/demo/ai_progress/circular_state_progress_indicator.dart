import 'package:flutter/material.dart';

import 'progress_mixin.dart';

///圆形进度条
class AirCircularStateProgressIndicator extends StatefulWidget {
  /// Limited min value
  static const double LIMITED_MIN_VALUE = 0;

  /// Limited max value
  static const double LIMITED_MAX_VALUE = 100;

  /// default value
  static const double DEFAULT_VALUE = 10;

  Size _size;
  double _min;
  double _max;
  num _value;
  Color _pathColor;
  Color _valueColor;
  double _pathStrokeWidth;
  double _valueStrokeWidth;
  bool _filled;
  bool _useCenter;
  bool _roundCap;

  /// constructor
  AirCircularStateProgressIndicator({
    @required Size size,
    double min = LIMITED_MIN_VALUE,
    double max = LIMITED_MAX_VALUE,
    num value = DEFAULT_VALUE,
    Color pathColor = Colors.white,
    Color valueColor = Colors.green,
    double pathStrokeWidth = 5,
    double valueStrokeWidth = 5,
    bool filled = false,
    bool useCenter = false,
    bool roundCap = true,
  }) {
    assert(size != null);
    assert(min >= LIMITED_MIN_VALUE);
    assert(max <= LIMITED_MAX_VALUE);
    assert(value >= min);
    assert(value <= max);
    assert(pathColor != null);
    assert(valueColor != null);
    assert(pathStrokeWidth != null);
    assert(valueStrokeWidth != null);
    assert(filled != null);
    assert(useCenter != null);
    assert(roundCap != null);
    _size = size;
    //value
    _value = value;
    _min = min;
    _max = max;
    //color
    _pathColor = pathColor;
    _valueColor = valueColor;
    //stroke width
    _pathStrokeWidth = pathStrokeWidth;
    _valueStrokeWidth = valueStrokeWidth;

    //
    _filled = filled;
    _useCenter = useCenter;
    _roundCap = roundCap;

    //The strokeWidth is zero when _filled is true,
    if (_filled) {
      _pathStrokeWidth = 0.0;
      _valueStrokeWidth = 0.0;
    }
  }

  @override
  _AirCircularStateProgressIndicatorState createState() =>
      _AirCircularStateProgressIndicatorState();
}

class _AirCircularStateProgressIndicatorState
    extends State<AirCircularStateProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RepaintBoundary(
        child: CustomPaint(
          size: widget._size,
          painter: A._(true, widget._min, widget._max, widget._value, _getPathPaint(),
              _getValuePaint(), widget._useCenter),
        ),
      ),
    );
  }

  Paint _getPathPaint() {
    return Paint()
      ..color = widget._pathColor
      ..strokeWidth = widget._pathStrokeWidth
      ..strokeCap = widget._roundCap ? StrokeCap.round : StrokeCap.square
      ..strokeJoin = widget._roundCap ? StrokeJoin.round : StrokeJoin.bevel
      ..style = widget._filled ? PaintingStyle.fill : PaintingStyle.stroke;
  }

  Paint _getValuePaint() {
    return Paint()
      ..color = widget._valueColor
      ..strokeWidth = widget._valueStrokeWidth
      ..strokeCap = widget._roundCap ? StrokeCap.round : StrokeCap.square
      ..strokeJoin = widget._roundCap ? StrokeJoin.round : StrokeJoin.bevel
      ..style = widget._filled ? PaintingStyle.fill : PaintingStyle.stroke;
  }
}

class A extends CustomPainter with ProgressMixin {
  final num maxSweepAngleExcludeCap = 6.2;
  final num maxSweepAngleIncludeCap = 6.5;
  final num minSweepAngle = 1.0;
  static const double DEFAULT_START_ANGLE = -1.5;

  bool _shouldRepaint;
  num _min;
  num _max;
  num _value;
  Paint _pathPaint;
  Paint _valuePaint;

  ///判断是否和中心点连接
  bool _useCenter;

  Size size;

  A._(this._shouldRepaint, this._min, this._max, this._value, this._pathPaint,
      this._valuePaint, this._useCenter);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    this.size = size;
    drawProgressPath(_pathPaint, canvas, size);

    drawProgressValue(_valuePaint, canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return _shouldRepaint;
  }

  @override
  drawProgressPath(Paint paint, Canvas canvas, Size size) {
    // TODO: implement drawProgressPath
    canvas.drawCircle(_getPoint, _getRadius, _pathPaint);
  }

  @override
  drawProgressValue(Paint paint, Canvas canvas, Size size) {
    // TODO: implement drawProgressValue
    canvas.drawArc(Rect.fromCircle(center: _getPoint, radius: _getRadius),
        DEFAULT_START_ANGLE, _getSweepAngle, _useCenter, paint);
  }

  ///求圆的中心
  Offset get _getPoint => Offset(size.width / 2, size.height / 2);

  ///求半径

  double get _getRadius {
    double d = (size.width < size.height ? size.width : size.height);
    d -= _valuePaint.strokeWidth;
    return d / 2;
  }

  /// 算出弧度大小

  double get _getSweepAngle {
    ///和最小值对比，小于设置最小值

    if (_value == _min) {
      _value = 0;
    }
    if (_value > _min && _value < _max / 2) {
      return _value * 0.0612;
    }

    if (_value == _max / 2) {
      return _value * 0.6;
    }

    if (_value > _max / 2 && _value < _max) {}

    if (_value == _max) {
      return maxSweepAngleIncludeCap;
    }
    return _value * 0.615;
  }
}
