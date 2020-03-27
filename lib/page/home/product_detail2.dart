import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/utils.dart';

class ProductDetail2 extends StatefulWidget {

  @override
  _ProductDetail2State createState() => _ProductDetail2State();
}

class _ProductDetail2State extends BasePageState<ProductDetail2>
    with SingleTickerProviderStateMixin {
  ScrollController _controller = new ScrollController();
  var globalKeyOne = GlobalKey();
  var globalKeyTwo = GlobalKey();
  var globalKeyThree = GlobalKey();
  var oneY = 0.0;
  var twoY = 0.0;
  var threeY = 0.0;

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return ListView(
      controller: _controller,
      children: <Widget>[
        Container(
          key: globalKeyOne,
          height: AppSize.height(300),
          color: Colors.blue,
          child: Text("商品"),
        ),
        Container(
          key: globalKeyTwo,
          color: Colors.green,
          height: AppSize.height(700),
          child: Text("详情"),
        ),
        Container(
          key: globalKeyThree,
          color: Colors.orange,
          height: AppSize.height(1500),
          child: Text("评价"),
        )
      ],
    );
  }

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    AppSize.init(context);
    return getScaffold();
  }

  @override
  void subInitState() {
    // TODO: implement subInitState
    oneY = getY(globalKeyOne.currentContext);
    twoY = getY(globalKeyTwo.currentContext);
    threeY = getY(globalKeyThree.currentContext);

    print('one=$oneY=two=$twoY=three=$threeY');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _controller.addListener(() {
      var of = _controller.offset;
      if (of > threeY - oneY) {
        _tabController.animateTo(2);
      }else if (of > twoY - oneY) {
        _tabController.animateTo(1);
      } else {
        _tabController.animateTo(0);
      }
      print("滚动了$of one=${twoY - oneY}=two=${threeY - oneY}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool useMyAppBar() => false;

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return AppBar(
      title: Container(
        alignment: Alignment.center,
        child: TabBar(
          onTap: (index){
            switch(index){
              case 0:
                _controller.jumpTo(0);
                _tabController.animateTo(0);
                break;
              case 1:
                _controller.jumpTo(twoY - oneY);
                _tabController.animateTo(1);
                break;
              case 2:
                _controller.jumpTo(threeY - oneY);
                _tabController.animateTo(2);
                break;
            }

          },
          controller: _tabController,
          labelColor: Colors.red,
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.black,
          tabs: <Widget>[
            Tab(
              child: Text("商品"),
            ),
            Tab(
              child: Text("详情"),
            ),
            Tab(
              child: Text("评价"),
            ),
          ],
        ),
      ),
    );
  }

}
