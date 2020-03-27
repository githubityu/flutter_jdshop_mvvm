import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(fit: StackFit.expand, children: [
      Image.asset('images/user_bg.jpg', fit: BoxFit.cover),
      Center(
          child: Opacity(
              opacity: 1 - shrinkOffset / expandedHeight,
              child: Offstage(
                  child: _listHeaderWid(),
                  offstage: shrinkOffset <= 20.0 ? false : true))),
      Positioned(
          top: 20.0,
          child: Container(
              height: 45.0,
              width: MediaQuery.of(context).size.width,
              child: Opacity(
                  opacity: 1,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Text('测试应用',
                                style: TextStyle(
                                    color: Color(0xFF333333), fontSize: 18.0))),
                        GestureDetector(
                            onTap: () {},
                            child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                                child: Image.asset(
                                    'images/icon_shelf_search.png',
                                    width: 22.0,
                                    height: 22.0))),
                        GestureDetector(
                            onTap: () async {},
                            child: Image.asset('images/icon_shelf_more.png',
                                width: 22.0, height: 22.0))
                      ])))))
    ]);
  }

  Widget _listHeaderWid() {
    return Container(
        height: 84.0,
        margin: EdgeInsets.only(top: 75.0),
        child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('精彩世界',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                            child: Text('点击兑换奖励',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0)))
                      ])),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 32.0,
                        width: 84.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            gradient: LinearGradient(colors: <Color>[
                              Colors.orange,
                              Colors.deepOrange
                            ]),
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Center(
                            child: Text('签到有奖',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0))))
                  ])
            ])));
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 75.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
