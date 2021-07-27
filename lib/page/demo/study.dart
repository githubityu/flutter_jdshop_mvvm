//dart学习
import 'dart:async';

import 'package:flutter/cupertino.dart';

Future<int> getId() async{
  return 5;
}


Stream<DateTime> getNumbers() async*{
  while(true){
    await Future.delayed(Duration(seconds: 1));
    yield DateTime.now();
  }
}



RoundedRectangleBorder getRo(){
  return RoundedRectangleBorder();
}

//shrinkWrap 有些控件默认填充父组件，该属性可以让组件包含而不是填充 例如gridView
//XXXBuilder 数据变化的时候会调用builder 所以不需要setState 避免在builder里面改变变量
//调用最小的范围的的setState

//组件默认大小 Stack 当没有位置组件的时候，大小会和子组件最大的一样
//如果都是有位置的组件的时候，会越大越好
//如果有有位置的和没有位置的组件的话，大小会和没有位置最大组件一样大，没有位置的最大组件可以作为参照物，
//有位置的组件 Align  Positioned Center 其他都是没有位置的默认左上角，位置组件的约束是松约束
//先布局没有位置的组件(作为参照物)，再布局有位置的组件，有位置的组件不会大于没有位置的组件，要不然没有任何意义

//没有位置的组件会听alignment的话
//clipBehavior 设置是否裁剪,Positioned 位置的值可以为负值


//StackFit
//loose  0-max
//expand max
//passthrough 直接把上一级的约束传给子组件




//需要渲染的组件，一些不需要渲染的组件
//StreamController.broadcast() 不能缓存事件，可以被多个监听，
//StreamController可以缓存事件，只能被一个监听
//StreamController 添加事件   stream 监听事件

//显式动画 手动创建Controller   XXXBuilder  TweenAnimationBuilder
//隐式动画 系统自动创建了Controller 不用自己创建  AnimatedXXX AnimatedSwitcher
//json文件动画

//start 从头开始，forward 从当前到末尾  repeat 循环播放动画 reverse 是否反向动画
//duration 可以随时修改

//SizedBox 可以强制设置宽高

//组件向里面传递约束，向外面传递尺寸，无法约束的大小，因为没有告诉放在那个位置，
// 加一个位置组件就可以满足设置的大小了

//紧约束，最小值和最大值一样`
//松约束loose 最小值是0的约束
//LayoutBuilder可以查看约束
//弹性和非弹性 先布局非弹性的，然后把剩余的空间分给有弹性的

//有限和无限约束  无界约束中不能包含无界约束的组件
// 例如 Column里面直接包含listView 由于listView 是非弹性组件并且是无限约束，
// 所以会失败，需要被弹性组件包含以下就可以了



//如果组件只设置了大小，没有位置就按照max，如果设置了位置和大小就正常显示


//ParentDataWidget 给父类传递信息的组件，如果没有信息，直接忽略掉，例如Posit



