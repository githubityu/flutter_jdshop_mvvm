import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutterjdshop/common/shared_util.dart';
import 'package:flutterjdshop/config/keys.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/utils/image_utils.dart';
import 'package:flutterjdshop/widget/load_image.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key, this.title}) : super(key: key);

  final String? title;


  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: do something to init
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      precacheImage(ImageUtils.getAssetImage('app_start_1'), context);
      goHome();
    });
  }

  goHome() {
    Future.delayed(Duration(milliseconds: 3000),(){
      if (SharedUtil.instance!.getBoolean(Keys.keyGuide, defValue: true)) {
        NavigatorUtils.push(context, ShopRouter.GUIDE_PAGE, replace: true);
      } else {
        NavigatorUtils.goRootPage(context);
      }});
  }
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        child: LoadAssetImage(
          'app_start_1',
          fit: BoxFit.fill,
        ),
      );
    });
  }
}
