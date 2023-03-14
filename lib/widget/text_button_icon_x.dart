import 'package:flutter/material.dart';

class TextButtonWithIconX extends TextButton {
  TextButtonWithIconX({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    Axis? direction,
    MainAxisSize? mainAxisSize,
    bool? isPre,
    double? gap,
    required Widget icon,
     Widget? label,
  }) : super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _TextButtonWithIconChild(
              icon: icon,
              mainAxisSize: mainAxisSize??MainAxisSize.min,
              label: label,
              direction: direction ?? Axis.horizontal,
              isPre: isPre ?? true,
              gap: gap ?? 8),
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.all(8),
      const EdgeInsets.symmetric(horizontal: 4),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(scaledPadding),
        );
  }
}

class _TextButtonWithIconChild extends StatelessWidget {
  const _TextButtonWithIconChild({
     this.label,
    required this.mainAxisSize,
    required this.icon,
    required this.direction,
    required this.isPre,
    required this.gap,
  });

  final Widget? label;
  final Axis direction;
  final MainAxisSize mainAxisSize;
  final Widget icon;
  final bool isPre;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final gapWidget = direction==Axis.horizontal?SizedBox(width: gap):SizedBox(height: gap);
    final labels = label==null?[icon]:isPre?[icon, gapWidget, label!]:[label!, SizedBox(width: gap), icon];
    return Flex(
      mainAxisSize: mainAxisSize,
      direction: direction,
      children: labels,
    );
  }
}

class OutlinedButtonWithIconX extends OutlinedButton {

  OutlinedButtonWithIconX({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.style,
    super.focusNode,
    Axis? direction,
    MainAxisSize? mainAxisSize,
    bool? isPre,
    double? gap,
    bool? autofocus,
    Clip? clipBehavior,
    required Widget icon,
    Widget? label,
  }) : super(
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _TextButtonWithIconChild(
              icon: icon,
              mainAxisSize: mainAxisSize??MainAxisSize.min,
              label: label,
              direction: direction ?? Axis.horizontal,
              isPre: isPre ?? true,
              gap: gap ?? 8),
        );
}





