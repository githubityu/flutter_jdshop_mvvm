import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutterjdshop/common/functions.dart';
import 'package:flutterjdshop/utils/app_size.dart';

import 'flutter_iconfont.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;

  final OnChangedCallback onChangedCallback;
  final FocusNode focusNode;

  SearchBar(
      {@required this.focusNode,
      @required this.controller,
      @required this.onChangedCallback});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
            child: InkWell(
                child: Container(
          width: AppSize.width(750),
          height: AppSize.height(72),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          child: TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            decoration: InputDecoration(
                hintText: '请输入商品名称',
                contentPadding:
                    EdgeInsets.symmetric(vertical: AppSize.height(25)),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintStyle: TextStyle(
                    fontSize: AppSize.sp(35), color: Color(0xff999999))),
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            onChanged: (str) {
              if (null != onChangedCallback) {
                onChangedCallback();
              }
            },
            focusNode: focusNode,
            controller: controller,
          ),
        ))),
      ],
    );
  }
}

class CommonBackTopBar extends StatelessWidget {
  final String title;
  final Widget leftW;
  final Widget rightW;
  final Function onLeft;
  final Function onRight;
  final bool isBack;

  CommonBackTopBar({
    @required this.title,
    this.onRight,
    this.leftW,
    this.rightW,
    this.onLeft,
    this.isBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 3),
          child: Text(title,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: AppSize.sp(40))),
        ),
        Positioned(
          left: 0,
          child: InkWell(
            onTap: isBack
                ? () {
                    Navigator.maybePop(context);
                  }
                : onLeft,
            child: isBack
                ? Padding(
                    padding: EdgeInsets.only(left: AppSize.width(20)),
                    child: Icon(IconFonts.arrow_left,
                        color: Colors.white, size: AppSize.height(60)),
                  )
                : leftW??Container(),
          ),
        ),
        Positioned(
          right: 0,
          child: InkWell(onTap: onRight, child: rightW ?? Container()),
        )
      ],
    );
  }
}
