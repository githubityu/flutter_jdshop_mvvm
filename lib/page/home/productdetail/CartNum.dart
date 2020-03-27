import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterjdshop/api/model/ProductContentModel.dart';
import 'package:flutterjdshop/utils/app_size.dart';


class CartNum extends StatefulWidget {
  ProductContentitem _productContent;
  
  CartNum(this._productContent,{Key key}) : super(key: key);

  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  ProductContentitem _productContent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._productContent=widget._productContent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.width(168),
      decoration:
          BoxDecoration(border: Border.all(width: AppSize.width(2), color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn()
        ],
      ),
    );
  }

  //左侧按钮

  Widget _leftBtn() {
    return InkWell(
      onTap: () {
        if( this._productContent.count>1){
          setState(() {
            this._productContent.count=this._productContent.count-1; 
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: AppSize.width(45),
        height: AppSize.height(45),
        child: Text("-"),
      ),
    );
  }

  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: (){

          setState(() {
            this._productContent.count=this._productContent.count+1; 
          });
      },
      child: Container(
        alignment: Alignment.center,
        width: AppSize.width(45),
        height: AppSize.height(45),
        child: Text("+"),
      ),
    );
  }

//中间
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: AppSize.width(70),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(width: AppSize.width(2), color: Colors.black12),
        right: BorderSide(width: AppSize.width(2), color: Colors.black12),
      )),
      height: AppSize.height(45),
      child: Text("${this._productContent.count}"),
    );
  }
}
