import 'package:flutter/material.dart';
import 'package:flutterjdshop/api/model/ProductContentModel.dart';
import 'package:flutterjdshop/provider/Cart.dart';
import 'package:flutterjdshop/receiver/event_bus.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/utils/CartServices.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/dialog_utils.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/widget/load_image.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';
import 'package:provider/provider.dart';

import 'CartNum.dart';

class ProductContentFirst extends StatefulWidget {
  final List productContentList;

  const ProductContentFirst(this.productContentList,{Key key})
      : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  ProductContentitem _productContent;

  List _attr = [];

  String _selectedValue;

  var actionEventBus;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._productContent = widget.productContentList[0];

    this._attr = this._productContent.attr;

    _initAttr();

    this.actionEventBus = eventBus.on<ProductContentEvent>().listen((str) {
      print(str);
      this._attrBottomSheet();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);


    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 12,
            child: LoadImage("${getFullPath(this._productContent.pic)}", fit: BoxFit.cover),
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("${this._productContent.title}",
                style: TextStyle(
                    color: Colors.black87, fontSize: AppSize.sp(36))),
          ),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text("${this._productContent.subTitle}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: AppSize.sp(28)))),
          //价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text("特价: "),
                      Text("¥${this._productContent.price}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: AppSize.sp(46))),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("原价: "),
                      Text("¥${this._productContent.oldPrice}",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: AppSize.sp(28),
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          this._attr.length > 0
              ? Container(
            margin: EdgeInsets.only(top: 10),
            height: AppSize.height(80),
            child: InkWell(
              onTap: () {
                _attrBottomSheet();
              },
              child: Row(
                children: <Widget>[
                  Text("已选: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("${this._selectedValue}")
                ],
              ),
            ),
          )
              : Text(""),
          Divider(),
          Container(
            height: AppSize.height(80),
            child: Row(
              children: <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  //销毁
  void dispose() {
    super.dispose();
    this.actionEventBus.cancel(); //取消事件监听
  }

  //初始化Attr 格式化数据
  _initAttr() {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      attr[i].attrList.clear(); //清空数组里面的数据

      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": true});
        } else {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": false});
        }
      }
    }

    // print(attr[0].attrList);
    // print(attr[0].cate);
    // print(attr[0].list);
    _getSelectedAttrValue();
  }

  //改变属性值
  _changeAttr(cate, title, setBottomState) {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      //注意  改变showModalBottomSheet里面的数据 来源于StatefulBuilder
      this._attr = attr;
    });
    _getSelectedAttrValue();
  }

  //获取选中的值
  _getSelectedAttrValue() {
    var _list = this._attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]["title"]);
        }
      }
    }
    // print(tempArr.join(','));
    setState(() {
      this._selectedValue = tempArr.join(',');
      //给筛选属性赋值
      this._productContent.selectedAttr = this._selectedValue;
    });
  }

  //循环具体属性
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            _changeAttr(attrItem.cate, item["title"], setBottomState);
          },
          child: Chip(
            label: Text("${item["title"]}",
                style: TextStyle(
                    color: item["checked"] ? Colors.white : Colors.black54)),
            padding: EdgeInsets.all(10),
            backgroundColor: item["checked"] ? Colors.red : Colors.black26,
          ),
        ),
      ));
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: AppSize.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: AppSize.height(22)),
              child: Text("${attrItem.cate}: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: AppSize.width(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem, setBottomState),
            ),
          )
        ],
      ));
    });

    return attrList;
  }

  //底部弹出框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (contex) {
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                //解决showModalBottomSheet点击消失的问题
                onTap: () {
                  return false;
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(AppSize.width(20)),
                      child: ListView(
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _getAttrWidget(setBottomState)),
                          Divider(),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: AppSize.height(80),
                            child: Row(
                              children: <Widget>[
                                Text("数量: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 10),
                                CartNum(this._productContent)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      width: AppSize.width(750),
                      height: AppSize.height(76),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: MyButton(
                                margin: EdgeInsets.all(0),
                                color: Color.fromRGBO(253, 1, 0, 0.9),
                                text: "加入购物车",
                                onPressed: () async {
                                  await CartServices.addCart(
                                      this._productContent);
                                  //关闭底部筛选属性
                                  Navigator.of(context).pop();
                                  //调用Provider 更新数据
                                  Provider.of<Cart>(context,listen: false).updateCartList();
                                  DialogUtil.buildToast("加入购物车成功");
                                },
                              ),
                            ),
                          ),
                          Gaps.hGap10,
                          Expanded(
                            flex: 1,
                            child: Container(
                                child: MyButton(
                                  margin: EdgeInsets.all(0),
                                  color: Color.fromRGBO(255, 165, 0, 0.9),
                                  text: "立即购买",
                                  onPressed: () {
                                    print('立即购买');
                                  },
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
