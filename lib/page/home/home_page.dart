import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterjdshop/api/model/product_view_model.dart';
import 'package:flutterjdshop/api/model/focus_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/res/colors.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/res/styles.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/utils/view_utils.dart';
import 'package:flutterjdshop/widget/load_image.dart';
import 'package:flutterjdshop/widget/view/load_state_layout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage>
    with AutomaticKeepAliveClientMixin {
  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];
  LoadState _layoutState = LoadState.State_Loading;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize.init(context);
    return getScaffold();
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      //调用接口
      _getFocusData();
      _getHotProductData();
      _getBestProductData();
    });
    super.initState();
  }

  _getFocusData() {
    focusViewModel.getData().then((onValue) {
      setState(() {
        this._focusData = onValue.result;
        _layoutState = LoadState.State_Success;
      });
    });
  }

  _getHotProductData() {
    productViewModel.getData().then((onValue) {
      setState(() {
        this._hotProductList = onValue.result;
        _layoutState = LoadState.State_Success;
      });
    });
  }

  _getBestProductData() {
    productViewModel.getData(type: 1).then((onValue) {
      setState(() {
        this._bestProductList = onValue.result;
        _layoutState = LoadState.State_Success;
      });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget _swiper() {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            getFullPath(this._focusData[index].pic),
            fit: BoxFit.fill,
          );
        },
        itemCount: _focusData.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }

  Widget _titleWidget(value) {
    return Container(
      height: AppSize.height(32),
      padding: EdgeInsets.only(left: AppSize.width(20)),
      margin: EdgeInsets.only(left: AppSize.width(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colours.fixedColor, width: AppSize.height(10)))),
      child: Text(
        value,
        style: TextStyles.textBlack14,
      ),
    );
  }

  Widget _hotProductListWidget() {
    return Container(
      height: AppSize.height(234),
      padding: EdgeInsets.all(AppSize.width(20)),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: AppSize.width(21)),
                child: ExcludeSemantics(
                    child: LoadImage(getFullPath(_hotProductList[index].sPic),
                        width: AppSize.width(140), height: AppSize.width(140))),
              ),
              Container(
                padding: EdgeInsets.only(top: AppSize.height(20)),
                height: AppSize.height(44),
                child: Text(
                  "¥${this._hotProductList[index].price}",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: _hotProductList.length,
      ),
    );
  }

  //推荐商品
  Widget _recProductListWidget() {
    var widthItem = AppSize.getItemWidth(2, 30);
    return Container(
      padding: EdgeInsets.all(AppSize.width(10)),
      child: Wrap(
        runSpacing: AppSize.width(10),
        spacing: AppSize.width(10),
        children: this._bestProductList.map((value) {
          return InkWell(
            onTap: () {
              NavigatorUtils.push(context, ShopRouter.PRODUCT_CONTENT,
                  params: {"id": value.sId});
            },
            child: Container(
              padding: EdgeInsets.all(AppSize.width(10)),
              width: widthItem,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      //防止服务器返回的图片大小不一致导致高度不一致问题
                      aspectRatio: 1 / 1,
                      child: ExcludeSemantics(
                          child: LoadImage(getFullPath(value.sPic),
                              width: widthItem, height: widthItem)),
                    ),
                  ),
                  Gaps.getGaps(20),
                  Text(
                    '${value.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.textBlack14,
                  ),
                  Gaps.getGaps(20),
                  Container(
                    height: 30,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          child: Text(
                            "¥${value.price}",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Text("¥${value.oldPrice}",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget getAppBar(BuildContext context) {
    return getSearchAppBar(context);
  }

  @override
  bool useMyAppBar() => false;

  @override
  void injectViewModelView() {
    // TODO: implement injectViewModelView
    productViewModel.cancelToken = getCancelToken();

    focusViewModel.cancelToken = getCancelToken();
  }

  @override
  Widget getBody(BuildContext context) {
    return LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        //重新加载当前数据
      },
      successWidget: ListView(
        children: <Widget>[
          _swiper(),
          Gaps.getGaps(20),
          _titleWidget("猜你喜欢"),
          Gaps.getGaps(20),
          _hotProductListWidget(),
          _titleWidget("热门推荐"),
          Gaps.getGaps(20),
          _recProductListWidget()
        ],
      ),
    );
  }
}
