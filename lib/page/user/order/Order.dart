import 'package:flutter/material.dart';
import 'package:flutterjdshop/api/model/OrderModel.dart';


import 'package:flutterjdshop/api/model/list_view_model.dart';
import 'package:flutterjdshop/api/model/void_modle.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/load_image.dart';

//订单列表数据模型

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends BasePageState<OrderPage> {
  List<Result> _orderList = [];

  @override
  void subInitState() {
    // TODO: implement subInitState
    super.subInitState();
    this._getListData();
  }


  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "订单列表");
  }
  void _getListData() async {
    var tempJson = {
      "uid": UserInfoData.instance.id,
      "salt": UserInfoData.instance.salt
    };
    var sign = getSign(tempJson);
    ListViewModel.get(this, getCancelToken()).getData(
        type: VoidModel.ORDERLIST,
        params2: {
          "uid": UserInfoData.instance.id,
          "sign": sign
        }).then((onValue) {
      setState(() {
        this._orderList = OrderModel.fromJson(onValue).result;
      });
    });
  }


  //自定义商品列表组件

  List<Widget> _orderItemWidget(orderItems) {
    List<Widget> tempList = [];
    for (var i = 0; i < orderItems.length; i++) {
      tempList.add(Column(
        children: <Widget>[
          SizedBox(height: 10),
          ListTile(
            leading: Container(
              width: AppSize.width(120),
              height: AppSize.height(120),
              child: LoadImage(
                '${getFullPath(orderItems[i].productImg)}',
                fit: BoxFit.cover,
              ),
            ),
            title: Text("${orderItems[i].productTitle}"),
            trailing: Text('x${orderItems[i].productCount}'),
          ),
          SizedBox(height: 10)
        ],
      ));
    }
    return tempList;
  }


  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, AppSize.height(80), 0, 0),
          padding: EdgeInsets.all(AppSize.width(16)),
          child: ListView(
              children: this._orderList.map((value) {
                return InkWell(
                  onTap: () {
                    NavigatorUtils.push(context, ShopRouter.ORDERINFO);
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("订单编号：${value.sId}",
                              style: TextStyle(color: Colors.black54)),
                        ),
                        Divider(),
                        Column(
                          children: this._orderItemWidget(value.orderItem),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          leading: Text("合计：￥${value.allPrice}"),
                          trailing: FlatButton(
                            child: Text("申请售后"),
                            onPressed: () {},
                            color: Colors.grey[100],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()),
        ),
        Positioned(
          top: 0,
          width: AppSize.width(750),
          height: AppSize.height(76),
          child: Container(
            width: AppSize.width(750),
            height: AppSize.height(76),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("全部", textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text("待付款", textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text("待收货", textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text("已完成", textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text("已取消", textAlign: TextAlign.center),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
