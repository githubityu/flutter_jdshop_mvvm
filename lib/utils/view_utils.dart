import 'package:flutter/material.dart';
import 'package:flutterjdshop/res/styles.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';

import 'app_size.dart';

AppBar getSearchAppBar(context){
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.center_focus_weak,
        color: Colors.black87,
      ),
      onPressed: null,
    ),
    title: InkWell(
      onTap: () {
        NavigatorUtils.push(context, ShopRouter.SEARCH);
      },
      child: Container(
        height: AppSize.height(68),
        decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        padding: EdgeInsets.only(left: AppSize.width(10)),
        child: Container(
          alignment: Alignment.center,
          child: FlatButton.icon(
              onPressed: () {
                NavigatorUtils.push(context, ShopRouter.SEARCH);
              },
              icon: Icon(Icons.search),
              label: Text(
                "笔记本",
                style: TextStyles.textSize16,
              )),
        ),
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.message,
          size: 28,
          color: Colors.black87,
        ),
        onPressed: null,
      )
    ],
  );
}