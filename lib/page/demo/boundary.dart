import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LayoutBoundaryDelegate extends MultiChildLayoutDelegate {
  LayoutBoundaryDelegate();

  static const String title = 'title';
  static const String summary = 'summary';
  static const String paintBoundary = 'paintBoundary';

  @override
  void performLayout(Size size) {
    print('TestLayoutDelegate  performLayout ');

    final BoxConstraints constraints = BoxConstraints(maxWidth: size.width);

    final Size titleSize = layoutChild(title, constraints);
    positionChild(title, Offset(0.0, 0.0));

    final double summaryY = titleSize.height;
    final Size descriptionSize = layoutChild(summary, constraints);
    positionChild(summary, Offset(0.0, summaryY));

    final double paintBoundaryY = summaryY + descriptionSize.height;
    final Size paintBoundarySize = layoutChild(paintBoundary, constraints);
    positionChild(
        paintBoundary, Offset(paintBoundarySize.width / 2, paintBoundaryY));
  }

  @override
  bool shouldRelayout(LayoutBoundaryDelegate oldDelegate) => false;
}

class LayoutBoundary extends StatefulWidget {
  LayoutBoundary({Key key}) : super(key: key);

  @override
  _LayoutBoundaryState createState() => _LayoutBoundaryState();
}

class _LayoutBoundaryState extends State<LayoutBoundary> {
  String _buttonText = 'h';
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text(
          '${_buttonText * _index}',
          textDirection: TextDirection.ltr,
          overflow: TextOverflow.ellipsis,
        ),
        onPressed: () {
          setState(() {
            _index++;
          });
        },
      ),
    );
  }
}

class PaintBoundary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: CirclePainter(color: Colors.orange));
  }
}

class CirclePainter extends CustomPainter {
  final Color color;

  const CirclePainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    print('CirclePainter paint');
    var radius = size.width / 2;
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(radius, size.height), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}