import 'package:flutter/material.dart';


import 'page.dart';
import 'page_state.dart';


class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends PageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TabsDemo')),
      body: NestedScrollView(
        headerSliverBuilder: (context, bool) {
          return [
            SliverPersistentHeader(
              pinned: true,
              delegate: MyStickyTabBarDelegate(
                child: PreferredSize(
                  preferredSize: Size.fromHeight(44),
                  child: Material(
                    child: TabBar(
                      labelStyle: TextStyle(fontSize: 14),
                      labelColor: Color(0xff000000),
                      unselectedLabelColor: Color(0xff999999),
                      controller: tabController,
                      tabs: <Widget>[
                        Tab(text: '出品方'),
                        Tab(text: '拍品'),
                        Tab(text: '拍場'),
                        Tab(text: '展覽'),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            Container(child: Tab1Page(TabName.TAB1)),
            Container(child: Tab1Page(TabName.TAB2)),
            Container(child: Tab1Page(TabName.TAB3)),
            Container(child: Tab1Page(TabName.TAB4)),
          ],
        ),
      ),
    );
  }
}

/// 吸顶tabs
class MyStickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  MyStickyTabBarDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
