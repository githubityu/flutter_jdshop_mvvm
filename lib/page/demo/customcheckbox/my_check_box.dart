import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterjdshop/utils/log_utils.dart';

///抽取出来缩小刷新区域
class MyCheckBox extends StatefulWidget {
  // 是否是check状态
  final bool isChecked;

  final Color colorBg;
  final Color color;
  final double size;

  // check回传
  final ValueChanged<bool> onChecked;

  MyCheckBox({
    Key key,
    this.isChecked,
    this.colorBg = Colors.red,
    this.color = Colors.blue,
    this.onChecked,
    this.size = 300,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CheckTextBox(isChecked: isChecked);

}

class CheckTextBox extends State<MyCheckBox> {
  // 是否是check状态 如何修改这个状态呢
  bool isChecked;

  CheckTextBox({this.isChecked: false});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Log.e("MyCheckBox=>build$isChecked");
    return Container(
      color: widget.colorBg,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isChecked = !isChecked;
            // 回传改变事件
            if (widget.onChecked != null) widget.onChecked(isChecked);
          });
        },

        ///防止过度重绘
        child: RepaintBoundary(
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: MyCheckBoxPainter(isCheck: isChecked),
          ),
        ),
      ),
    );
  }

  void setChecked(bool isCheck) {
    isChecked = isCheck;
  }
}

class MyCheckBoxPainter extends CustomPainter {
  final _paint = Paint();
  bool isCheck = false;
  Color color;
  MyCheckBoxPainter({this.isCheck = false, this.color = Colors.blue}) {
    _paint.color = color; //白色笔
    _paint.isAntiAlias = true; // 抗锯齿
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    double _center = size.height / 2; //中心点
    _paint.strokeWidth = size.height * 0.12; // 设置空心圆的宽度
    double _radius = _center - _paint.strokeWidth / 2; //半径
    _paint.style = PaintingStyle.stroke; // 设置空心笔
    ///圆形半径为（width-笔的宽度）/2
    ///画弧形是矩形内切
    canvas.drawCircle(Offset(_center, _center), _radius, _paint);
    if (isCheck) {
      _paint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(_center, _center), _radius / 2, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return (oldDelegate as MyCheckBoxPainter).isCheck != isCheck;
  }
}
