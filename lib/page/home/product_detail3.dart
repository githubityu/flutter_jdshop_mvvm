import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterjdshop/api/model/ProductContentModel.dart';
import 'package:flutterjdshop/api/model/void_modle.dart';
import 'package:flutterjdshop/api/model/void_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/provider/Cart.dart';
import 'package:flutterjdshop/receiver/event_bus.dart';
import 'package:flutterjdshop/res/colors.dart';
import 'package:flutterjdshop/res/dimens.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/res/styles.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/utils/CartServices.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/theme_utils.dart';
import 'package:flutterjdshop/widget/load_image.dart';
import 'package:flutterjdshop/widget/view/load_state_layout.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';
import 'package:provider/provider.dart';

import 'productdetail/ProductContent.dart';

class ProductDetail3 extends StatefulWidget {
  final String sId;

  const ProductDetail3({this.sId});

  @override
  _ProductDetail3State createState() => _ProductDetail3State();
}

class _ProductDetail3State extends BasePageState<ProductDetail3>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isDark = false;
  LoadState state = LoadState.State_Loading;
  List _productContentList = [];

  @override
  bool useMyAppBar() => false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  static const titles = ['商品', '详情', '评价'];
  var tabs = [
    Tab(
      child: Text(titles[0]),
    ),
    Tab(
      child: Text(titles[1]),
    ),
    Tab(
      child: Text(titles[2]),
    )
  ];

  @override
  void subInitState() {
    // TODO: implement subInitState
    super.subInitState();
    VoidViewModel.get(this, getCancelToken()).getData(
        type: VoidModel.PCONTENT, params2: {"id": widget.sId}).then((onValue) {
      setState(() {
        _productContentList.add(ProductContentitem.fromJson(onValue));
        state = LoadState.State_Success;
      });
    });
  }

  @override
  Widget getBody(BuildContext context) {
    isDark = ThemeUtils.isDark(context);
    // TODO: implement getBody
    return NestedScrollView(
      key: const Key('order_list'),
      physics: ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) =>
          _sliverBuilder(context),
      body: LoadStateLayout(
        successWidget: Container(
          child: Stack(
            children: <Widget>[
              TabBarView(
                key: const Key('pageView'),
                controller: _tabController,
                children: titles.map((f) {
                  return ProductContent(f, titles.indexOf(f));
                }).toList(),
              ),
              Positioned(
                bottom: 0,
                width: AppSize.getWidth(),
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(color: Colors.black12, width: 1))),
                  child: Row(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {},
                          ),
                          Consumer<Cart>(
                            builder: (context, p, child) {
                              return p.cartList.length > 0
                                  ? Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 3, 6, 3),
                                          decoration: BoxDecoration(
                                              color: Colors.pink,
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: Text(
                                            "${p.cartList.length}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: AppSize.sp(22)),
                                          )),
                                    )
                                  : Container();
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: MyButton(
                          color: Colors.green,
                          margin: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              if (this._productContentList[0].attr.length > 0) {
                                //广播 弹出筛选
                                eventBus.fire(new ProductContentEvent());
                              } else {
                                CartServices.addCart(
                                    this._productContentList[0]);
                                //调用Provider 更新数据
                                Provider.of<Cart>(context, listen: false)
                                    .updateCartList();
                                showToast('加入购物车成功');
                              }
                            });
                          },
                          text: "加入购物车",
                        ),
                      ),
                      Gaps.hGap10,
                      Expanded(
                        child: MyButton(
                          margin: EdgeInsets.all(0),
                          onPressed: () {},
                          text: "立即购买",
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        state: state,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: SliverAppBar(
          bottom: PreferredSize(
            child: Container(),
            preferredSize: Size.fromHeight(0),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              NavigatorUtils.pop(context);
            },
          ),
          brightness: Brightness.dark,
          backgroundColor: Colors.blue,
          elevation: 0.0,
          centerTitle: true,
          //拉伸的高度
          expandedHeight: 210.0,
          title: Text("商品详情"),
          floating: false,
          // 不随着滑动隐藏标题
          pinned: true,
          // 固定在顶部  可以拉伸的布局
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: <Widget>[
                //空出空间，为了让下面正式的内容不被上面固定的appbar所遮挡
                Container(
                  width: double.infinity,
                  //该高度和SliverPersistentHeader 一致
                  height: AppSize.height(80) + ScreenUtil.statusBarHeight,
                  color: Colors.red,
                  child: Text(""),
                ),
                //真正需要拉伸的布局，该布局拉伸显示，缩小隐藏
                Expanded(
                  flex: 1,
                  child: headerView(),
                ),
              ],
            ),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            Container(
              color: Colors.white,
              height: 50.0,
              padding: const EdgeInsets.only(top: 8.0),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                controller: _tabController,
                labelColor: ThemeUtils.isDark(context)
                    ? Colours.dark_text
                    : Colours.red,
                unselectedLabelColor: ThemeUtils.isDark(context)
                    ? Colours.dark_text_gray
                    : Colours.red,
                labelStyle: TextStyles.textBold14,
                unselectedLabelStyle: const TextStyle(
                  fontSize: Dimens.font_sp14,
                ),
                indicatorColor: Colors.red,
                tabs: tabs,
                onTap: (index) {
                  if (!mounted) {
                    return;
                  }
                },
              ),
            ),
            50.0),
      ),
    ];
  }

  Widget headerView() {
    return Column(
      children: <Widget>[
        ExcludeSemantics(
            child: LoadImage(
                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584946415776&di=12c9a77d06d183265549b22c66a21545&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20181003%2F0f8307fe3de6468d8b51c53b276e9e1b.jpeg",
                width: AppSize.getWidth(),
                height: 130)),
        Text("测试布局")
      ],
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;

  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
