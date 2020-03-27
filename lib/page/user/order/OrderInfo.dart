import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/view/app_topbar.dart';

class OrderInfoPage extends StatefulWidget {
  OrderInfoPage({Key key}) : super(key: key);

  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends BasePageState<OrderInfoPage> {

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "订单详情",);
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      child: ListView(
        children: <Widget>[
          //收货地址
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.add_location),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("张三  15201686455"),
                      SizedBox(height: 10),
                      Text("北京市海淀区 西二旗"),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          SizedBox(height: 16),
          //列表
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: AppSize.width(120),
                      child: Image.network(
                          "https://www.itying.com/images/flutter/list2.jpg",
                          fit: BoxFit.cover),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54)),
                              Text("水龙头 洗衣机",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54)),
                              ListTile(
                                leading: Text("￥100",
                                    style: TextStyle(color: Colors.red)),
                                trailing: Text("x2"),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: AppSize.width(120),
                      child: Image.network(
                          "https://www.itying.com/images/flutter/list2.jpg",
                          fit: BoxFit.cover),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54)),
                              Text("水龙头 洗衣机",
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black54)),
                              ListTile(
                                leading: Text("￥100",
                                    style: TextStyle(color: Colors.red)),
                                trailing: Text("x2"),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),

          //详情信息
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[

                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text("订单编号:",style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("124215215xx324")
                    ],
                  ),
                ),

                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text("下单日期:",style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("2019-12-09")
                    ],
                  ),
                ),

                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text("支付方式:",style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("微信支付")
                    ],
                  ),
                ),

                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text("配送方式:",style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("顺丰")
                    ],
                  ),
                )

              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: <Widget>[
                ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("总金额:",style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("￥414元",style: TextStyle(
                            color: Colors.red
                        ))
                      ],
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
