import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/bean/option_bean.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/receiver/event_bus.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/res/styles.dart';
import 'package:flutterjdshop/routes/demo_router.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/image_utils.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/utils/view_utils.dart';
import 'package:flutterjdshop/widget/dialog/remind_dialog.dart';
import 'package:flutterjdshop/widget/load_image.dart';
import 'package:flutterjdshop/widget/view/load_state_layout.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends BasePageState<UserPage>
    with AutomaticKeepAliveClientMixin {
  List<OptionBean> titles2 = [
    OptionBean(
        first: "全部订单",
        second: Icon(
          Icons.assignment,
          color: Colors.red,
        ),
        third: ShopRouter.ADDRESS_LIST),
    OptionBean(
        first: "待付款",
        second: Icon(
          Icons.payment,
          color: Colors.green,
        ),
        third: ShopRouter.ORDER),
    OptionBean(
        first: "待收货",
        second: Icon(
          Icons.local_car_wash,
          color: Colors.orange,
        ),
        third: ShopRouter.ORDER),
    OptionBean(
        first: "我的收藏",
        second: Icon(
          Icons.favorite,
          color: Colors.lightGreen,
        ),
        third: ShopRouter.ORDER),
    OptionBean(
        first: "demo列表",
        second: Icon(
          Icons.people,
          color: Colors.black54,
        ),
        third: DemoRouter.DEMOLIST),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize.init(context);
    return getScaffold();
  }

  @override
  Widget getBody(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: getListTitle(),
      ),
    );
  }

  Widget topWidget() {
    return Container(
      height: AppSize.height(200),
      padding: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: ImageUtils.getAssetImage('user_bg', format: "jpg"))),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ClipOval(
              child: LoadImage(
                "user",
                width: AppSize.width(100),
                height: AppSize.width(100),
              ),
            ),
          ),
          !UserInfoData.instance.isLogin
              ? Expanded(
                  child: InkWell(
                    onTap: () {
                      NavigatorUtils.push(context, ShopRouter.LOGIN);
                    },
                    child: Text(
                      "登录/注册",
                      style: TextStyles.textWhite,
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "用户名：${UserInfoData.instance.account}",
                          textAlign: TextAlign.left,
                          style: TextStyles.textWhite14,
                        ),
                        Text(
                          "普通会员",
                          style: TextStyles.textWhite14,
                        ),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }

  _showExitDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => RemindDialog(
              content: "确定要退出登录",
              confirmFunc: () {
                setState(() {
                  NavigatorUtils.pop(context);
                  UserInfoData.instance.setAccount("");
                });
              },
            ));
  }

  Widget bottomButton() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: MyButton(
          text: "退出登录",
          onPressed: () {
            _showExitDialog();
          }),
    );
  }

  List<Widget> getListTitle() {
    List<Widget> wids = [topWidget()];
    titles2.map((f) {
      wids.add(ListTile(
        leading: f.second,
        title: Text(f.first),
        onTap: () {
          NavigatorUtils.push(context, f.third);
        },
      ));
      wids.add(Gaps.line);
    }).toList();
    if (UserInfoData.instance.isLogin) wids.add(bottomButton());
    return wids;
  }

  @override
  bool useMyAppBar() => false;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void subInitState() {
    eventBus.on<MineChangeEvent>().listen((event) {
      setState(() {});
    });
  }
}
