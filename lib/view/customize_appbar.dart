import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutterjdshop/res/colors.dart';
import 'package:flutterjdshop/utils/app_size.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  @override
  final Size preferredSize;

  const MyAppBar({
    Key key,
    @required this.child,
     this.preferredSize,
  }) : super(key: key);

  void initStateBar() async{
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    double _statusHeight = ScreenUtil.statusBarHeight;
    return Container(
      padding: EdgeInsets.only(left: 6, right: 6,top: _statusHeight),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colours.app_main, Colours.app_main],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      height: preferredSize.height+_statusHeight,
//        color: Theme.of(context).primaryColor,
      child: this.child,
    );
  }
}
