import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutterjdshop/common/shared_util.dart';
import 'package:flutterjdshop/config/const.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/utils/image_utils.dart';
import 'package:flutterjdshop/utils/theme_utils.dart';
import 'package:flutterjdshop/widget/load_image.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  int _status = 0;
  List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      // 由于SpUtil未初始化，所以MaterialApp获取的为默认主题配置，这里同步一下。
      if (SharedUtil.instance!.getBoolean(Keys.keyGuide, defValue: true)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    Future.delayed(Duration(milliseconds: 1500),(){
      SharedUtil.instance!.saveBoolean(Keys.keyGuide, false);
      // _initGuide();
      _goLogin();
    });
  }

  _goLogin() {
    NavigatorUtils.goRootPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: ThemeUtils.getBackgroundColor(context),
        child: _status == 0
            ? Align(
                alignment: FractionalOffset(
                  0.33 / (1.0 - 0.33),
                  0.3/(1-0.3)
                ),
              child: FractionallySizedBox (
                  heightFactor: 0.3,
                  widthFactor: 0.33,
                  child: const LoadAssetImage('banner',format: IMAGE_JPG,)),
            )
            : Container(child: Text("替换"),alignment: Alignment.center,),);
  }
}
