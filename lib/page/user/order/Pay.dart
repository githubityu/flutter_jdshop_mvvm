import 'package:flutter/material.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';


class PayPage extends StatefulWidget {
  PayPage({Key key}) : super(key: key);

  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends BasePageState<PayPage> {
  List payList = [
    {
      "title": "支付宝支付",
      "chekced": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信支付",
      "chekced": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];


  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "支付");
  }
  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return  Column(
      children: <Widget>[
        Container(
            height: 400,
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: this.payList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading:
                      Image.network("${this.payList[index]["image"]}"),
                      title: Text("${this.payList[index]["title"]}"),
                      trailing: this.payList[index]["chekced"]
                          ? Icon(Icons.check)
                          : Text(""),
                      onTap: () {
                        //让payList里面的checked都等于false
                        setState(() {
                          for (var i = 0; i < this.payList.length; i++) {
                            this.payList[i]['chekced'] = false;
                          }
                          this.payList[index]["chekced"] = true;
                        });
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            )),
        MyButton(
          margin: EdgeInsets.all(0),
          text: "支付",
          color: Colors.red,
          onPressed: () {
            print('支付1111');
          },
        )
      ],
    );
  }
}
