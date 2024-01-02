
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/utils/number_text_input_formatter.dart';


/// 封装输入框
class TextFieldItem extends StatelessWidget {

  const TextFieldItem({
    Key? key,
    this.controller,
    required this.title,
    this.keyboardType = TextInputType.text,
    this.hintText = '',
    this.focusNode,
  }): super(key: key);

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
            bottom: Divider.createBorderSide(context, width: 0.6),
          )
      ),
      child: Row(
        children: <Widget>[
          Text(title),
          Gaps.hGap16,
          Expanded(
            child: TextField(
              focusNode: focusNode,
              keyboardType: keyboardType,
              inputFormatters: _getInputFormatters(),
              controller: controller,
              //style: TextStyles.textDark14,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none, //去掉下划线
                //hintStyle: TextStyles.textGrayC14
              )
            ),
          ),
          Gaps.hGap16
        ],
      ),
    );
  }

  _getInputFormatters() {
    if (keyboardType == TextInputType.numberWithOptions(decimal: true)) {
      return [UsNumberTextInputFormatter()];
    }
    if (keyboardType == TextInputType.number || keyboardType == TextInputType.phone) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
