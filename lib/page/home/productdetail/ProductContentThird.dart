import 'package:flutter/material.dart';

class ProductContentThird extends StatefulWidget {
  ProductContentThird({Key key}) : super(key: key);

  _ProductContentThirdState createState() => _ProductContentThirdState();
}

class _ProductContentThirdState extends State<ProductContentThird>  with AutomaticKeepAliveClientMixin{
  
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView.builder(
         itemCount: 50,
         itemBuilder: (context,index){
           return ListTile(
             title: Text("第${index}条"),
           );

         },
       )
    );
  }
}