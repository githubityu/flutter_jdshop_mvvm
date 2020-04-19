import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'dart:math' as math;

///动画实现一般有两种，一种是继承AnimatedWidget 一种是AnimatedBuilder
/// 他们都需要 AnimationController 动画控制器
/// AnimatedBuilder 估值器和插值器组合A以后 交给AnimationController 然后，组件里面的属性值可以根据A.value来改变组件的属性
/// AnimatedWidget 估值器和插值器组合A以后放到组件对应的属性值上面(Animation<double>)
/// Tween 范围  Curves快慢，  最后直接或者间接调用transform设置值来改变属性

class AnimationThree extends StatefulWidget {
  @override
  _AnimationThreeState createState() => _AnimationThreeState();
}

class _AnimationThreeState extends BasePageState<AnimationThree>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _controller;
  Animation groupAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  IconData _icon = Icons.stop;

  @override
  Widget getAppBar(BuildContext context) {
    return CommonBackTopBar(
      title: "动画学习",
      rightW: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: IconButton(
          key: ValueKey(_icon),
          icon: Icon(_icon),
          onPressed: () {
            setState(() {
              _icon = (_icon == Icons.stop) ? Icons.play_arrow : Icons.stop;
              _playAnimation();
            });
          },
        ),
      ),
    );
  }

  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _animationController.forward().orCancel;
      //再执行反向动画
      await _animationController.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
      print(' cancel');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      child: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              RotationTransition(
                alignment: Alignment.center,
                turns: _animationController,
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text("旋转动画"),
                ),
              ),
              ScaleTransition(
                scale: _animationController,
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text("缩放"),
                ),
              ),
              Container(
                width: 100,
                child: GroupAnimalWidget(
                  controller: _animationController,
                  child: Text("旋转和缩放"),
                ),
              )
            ],
          ),
          //解除父元素的限制
          UnconstrainedBox(
            child: Container(
              height: 50,
              width: 100,
              color: Colors.red,
              child: Container(
                width: 200,
                height: 30,
                child: Text("========"),
              ),
            ),
          ),
          MyStatefulWidget(
            controller: _controller,
          )
        ],
      ),
    );
  }
}

///组合动画学习
class GroupAnimalWidget extends StatelessWidget {
  final AnimationController controller;
  final Widget child;
  Animation<double> groupAnimation;
  Animation<double> height;

  GroupAnimalWidget({Key key, this.controller, this.child}) : super(key: key) {
    var d2 = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Interval(0.0, 1, curve: Curves.ease)));
    var d1 = Tween(begin: 0.0, end: 50.0);
    groupAnimation = controller.drive(d2);
    height = controller.drive(d1);

    //监听值
    height.addListener(() {
      print(height.value);
    });
    //监听状态
    height.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          // TODO: Handle this case.
          break;
        case AnimationStatus.forward:
          // TODO: Handle this case.
          break;
        case AnimationStatus.reverse:
          // TODO: Handle this case.
          break;
        case AnimationStatus.completed:
          // TODO: Handle this case.
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _b2);
  }

  Widget _b(BuildContext context, Widget child2) {
    return Opacity(
      opacity: 1 - groupAnimation.value,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 100),
        child: Container(
          color: Colors.red,
          width: 100.0 * groupAnimation.value,
          height: 50,
          child: Transform(
            transform: Matrix4.rotationZ(groupAnimation.value * math.pi * 2.0),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _b2(BuildContext context, Widget child2) {
    return Opacity(
      opacity: 1 - groupAnimation.value,
      child: UnconstrainedBox(
        child: Container(
          color: Colors.red,
          width: 100.0 * groupAnimation.value,
          height: 50.0 * groupAnimation.value,
          child: Transform(
            transform: Matrix4.rotationZ(groupAnimation.value * math.pi * 2.0),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final AnimationController controller;

  const MyStatefulWidget({Key key, this.controller}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _offsetAnimation = Tween<Offset>(
      ///Offset(1.0,2.0) 代表相对自己x轴移动一倍的自己 y轴移动2倍的自己
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: FlutterLogo(size: 150.0),
      ),
    );
  }
}
