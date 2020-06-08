import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/page/demo/ai_progress/yuanxing/one_circle.dart';
import 'package:flutterjdshop/page/demo/timeclock/clock.dart';
import 'package:flutterjdshop/page/demo/timeclock/thermometer.dart';
import 'package:flutterjdshop/view/app_topbar.dart';

import 'circular_state_progress_indicator.dart';
import 'yuanxing/two_circle.dart';

class AiProgressDemo extends StatefulWidget {
  @override
  _AiProgressDemoState createState() => _AiProgressDemoState();
}

class _AiProgressDemoState extends BasePageState<AiProgressDemo>
    with SingleTickerProviderStateMixin {
  int _index = 1;

  static const double MAX = 10.0;
  static const double MIN = 1.0;
  static int _divisions = 99;

  double _progressValue = 1;
  double _slideValue = MAX;

  List<double> values = [1, 1, 1, 1, 1];
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.brown,
    Colors.blue
  ];

  AnimationController _controller;
  Animation<int> _valueTween;
  Animation<int> _valueTween2;


  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _valueTween = _controller.drive(IntTween(
      begin: 1,
      end: 10,
    ));
    _valueTween2 = _controller.drive(IntTween(
      begin: 1,
      end: 5,
    ));
    _valueTween.addListener(() {
      setState(() {
        _index = _valueTween.value;
        print("_index=$_index");
      });
    });
    super.initState();
  }

  @override
  Widget getAppBar(BuildContext context) {
    return CommonBackTopBar(
      title: "ai_progress 学习",
      rightW: Text("开启"),
      onRight: () {
        _playAnimation();
      },
    );
  }

  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller
          .forward()
          .orCancel;
      //再执行反向动画
      await _controller
          .reverse()
          .orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
      print(' cancel');
    }
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return ListView(
      children: <Widget>[
        UnconstrainedBox(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context,child){
              return OneCircle(
                colors: colors,
                values:  values,
                index: _valueTween2==null?-1:_valueTween2.value,
              );
            },
          ),
        )
        ,
        UnconstrainedBox(
          child: Container(
            color: Colors.green,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return TwoCircle(Colors.red, Colors.blue, 10,
                    _valueTween.value.toDouble() * 10);
              },
            ),
          ),
        )
        ,
//        UnconstrainedBox(
//          child: Container(
//            color: Colors.green,
//            child: ClockPage(),
//          ),
//        )
//        ,
//        UnconstrainedBox(
//          child: Container(
//            color: Colors.green,
//            child: ThermometerPage(
//              width: 300,
//              degree: 50,
//            ),
//          ),
//        ),
        Row(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(5),
              child: AirCircularStateProgressIndicator(
                size: Size(100, 100),
                value: _index / 10 * 100,
                //1~100
                pathColor: Colors.white,

                ///可以通过其他值来改变颜色
                valueColor:
                ColorTween(begin: Colors.grey, end: Colors.blue)
                    .transform(_index / 10),
                pathStrokeWidth: 10.0,
                valueStrokeWidth: 10.0,
                useCenter: true,
                filled: false,
                roundCap: true,
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(5),
                  child: AirCircularStateProgressIndicator(
                    size: Size(100, 100),
                    value: _valueTween == null ? 0 : _valueTween.value / 10 *
                        100,
                    //1~100
                    pathColor: Colors.white,

                    ///可以通过其他值来改变颜色
                    valueColor:
                    ColorTween(begin: Colors.grey, end: Colors.blue)
                        .transform(
                        _valueTween == null ? 0 : _valueTween.value / 10),
                    pathStrokeWidth: 10.0,
                    valueStrokeWidth: 10.0,
                    useCenter: true,
                    filled: false,
                    roundCap: true,
                  ),
                );
              },
            )
          ],
        )
      ],

    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
