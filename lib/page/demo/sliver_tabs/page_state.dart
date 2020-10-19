import 'package:flutter/material.dart';

import 'page2.dart';



/// 关注页签名称
enum TabName {
  TAB1,
  TAB2,
  TAB3,
  TAB4,
}

abstract class PageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  TabController tabController;

  /// 切换页签
  VoidCallback _toggleTabListener() {
    if (!tabController.indexIsChanging) {
      toggleTab(tabController.index);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(_toggleTabListener);
  }

  @override
  void dispose() {
    tabController.removeListener(_toggleTabListener);
    tabController.dispose();
    super.dispose();
  }

  toggleTab(tabIndex) {
    print(tabIndex);
  }
}
