import 'package:flutter/material.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/widget/load_image.dart';

import 'package:provider/provider.dart';
import '../../provider/Cart.dart';
import 'CartNum.dart';

class CartItem extends StatefulWidget {
  Map _itemData;
  CartItem(this._itemData,{Key key}) : super(key: key);

  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map _itemData;
   
  @override
  Widget build(BuildContext context) {
    //注意：给属性赋值
    this._itemData=widget._itemData;

    var cartProvider = Provider.of<Cart>(context);
    return Container(
      height: AppSize.height(220),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          Container(
            width: AppSize.width(60),
            child: Checkbox(
              value: _itemData["checked"],
              onChanged: (val) {
               _itemData["checked"]=!_itemData["checked"];
               cartProvider.itemChage();
              },
              activeColor: Colors.pink,
            ),
          ),
          Container(
            width: AppSize.width(160),
            child: LoadImage(
                "${getFullPath(_itemData["pic"])}",
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
                  Text("${_itemData["title"]}",
                      maxLines: 2),
                  Text("${_itemData["selectedAttr"]}",
                      maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("￥${_itemData["price"]}",style: TextStyle(
                          color: Colors.red
                        )),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(_itemData),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
