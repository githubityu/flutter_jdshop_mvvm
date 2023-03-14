import 'package:flutter/material.dart';

/// create at 2022/1/4 15:24
/// by githubityu
/// describe：

///包含还是填充
@immutable
class TextIcon extends StatelessWidget {
  const TextIcon(
      {Key? key,
      mainAxisSize,
      this.axis = Axis.horizontal,
      this.text,
      this.textStyle,
      this.isPre = true,
      this.space = 8,
      this.isExpand,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      required this.icon})
      : mainAxisSize = mainAxisSize ?? MainAxisSize.min,
        super(key: key);
  final MainAxisSize mainAxisSize;
  final Axis axis;
  final bool isPre;
  final double space;
  final String? text;
  final bool? isExpand;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget icon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      direction: axis,
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    final widgets = <Widget>[];
    widgets.add(icon!);
    Widget textChild = Padding(
      padding: axis == Axis.horizontal
          ? EdgeInsets.only(
              left: (isPre ? space : 0), right: (isPre ? 0 : space))
          : EdgeInsets.only(
              top: (isPre ? space : 0), bottom: (isPre ? 0 : space)),
      child: Text(
        text ?? '',
        textAlign: TextAlign.start,
        style: textStyle,
      ),
    );
    if (isExpand == true) {
      textChild = Expanded(child: textChild);
    }
    widgets.add(textChild);
    if (!isPre) {
      return widgets.reversed.toList();
    }
    return widgets;
  }
}
