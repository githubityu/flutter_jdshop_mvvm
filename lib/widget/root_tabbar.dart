import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/common/common.dart';
import 'package:flutterjdshop/receiver/event_bus.dart';
import 'package:flutterjdshop/res/colors.dart';
import 'package:flutterjdshop/utils/app_size.dart';

import 'scroll/my_behavior.dart';

class RootTabBar extends StatefulWidget {
  RootTabBar({this.pages, this.currentIndex = 0});

  final List pages;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() => new RootTabBarState();
}

class RootTabBarState extends State<RootTabBar> {
  var pages = new List<BottomNavigationBarItem>();
  int currentIndex;
  var contents = new List<Offstage>();
  PageController pageController;

  StreamSubscription _indexSubscription;

  void _listen() {
    _indexSubscription = eventBus.on<TabIndexEvent>().listen((event) {
      int index = event.num;
      this.currentIndex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    pageController = PageController(initialPage: currentIndex);
    for (int i = 0; i < widget.pages.length; i++) {
      TabBarModel model = widget.pages[i];
      pages.add(
        new BottomNavigationBarItem(
          icon: model.icon,
          activeIcon: model.selectIcon,
          title: new Text(model.title, style: new TextStyle(fontSize: 12.0)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    _listen();
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: pages,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      unselectedItemColor: Colours.mainTextColor,
      fixedColor: Colours.fixedColor,
      onTap: (int index) {
        setState(() => currentIndex = index);
       // pageController.jumpToPage(currentIndex);
        eventBus.fire(TabIndexEvent(index));
      },
      unselectedFontSize: 18.0,
      selectedFontSize: 18.0,
      elevation: 0,
    );


    return new Scaffold(
      bottomNavigationBar: new Theme(
        data: new ThemeData(
          canvasColor: Colors.grey[50],
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: new Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colours.lineColor, width: 0.2))),
          child: bottomNavigationBar,
        ),
      ),
      body: new ScrollConfiguration(
        behavior: MyBehavior(),
        child: new PageView.builder(
          itemBuilder: (BuildContext context, int index) =>
              widget.pages[index].page,
          controller: pageController,
          itemCount: pages.length,
          physics: Platform.isAndroid
              ? new ClampingScrollPhysics()
              : new NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() => currentIndex = index);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _indexSubscription.cancel();
  }
}

class TabBarModel {
  const TabBarModel({this.title, this.page, this.icon, this.selectIcon});

  final String title;
  final Widget icon;
  final Widget selectIcon;
  final Widget page;
}
