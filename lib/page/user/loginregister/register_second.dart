import 'package:flutter/material.dart';
import 'package:flutterjdshop/api/model/void_modle.dart';
import 'package:flutterjdshop/api/model/void_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/dialog_utils.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';
import 'package:flutterjdshop/widget/view/text_field.dart';

class RegisterSecond extends StatefulWidget {
  String tel;

  RegisterSecond(this.tel);

  @override
  _RegisterSecondState createState() => _RegisterSecondState();
}

class _RegisterSecondState extends BasePageState<RegisterSecond> {
  TextEditingController codeC = TextEditingController();
  FocusNode codeF = FocusNode();

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      padding: EdgeInsets.all(AppSize.width(20)),
      child: ListView(
        children: <Widget>[
          Gaps.vGap10,
          Padding(
            padding: EdgeInsets.only(left: AppSize.width(10)),
            child: Text("验证码已经发送到了您的${widget.tel}手机，请输入${widget.tel}手机号收到的验证码"),
          ),
          Gaps.vGap10,
          MyTextField(
            key: Key("code"),
            controller: codeC,
            focusNode: codeF,
            hintText: "请输入验证码",
            maxLength: 4,
            keyboardType: TextInputType.number,
            getVCode: () async {
//              VoidViewModel.get(this, getCancelToken()).getData(
//                  type: VoidModel.SEND_CODE,
//                  params2: {"tel": widget.tel}).then((onValue) {
//                DialogUtil.buildToast("跳转了");
//                return true;
//              });
              return true;
            },
          ),
          Gaps.vGap10,
          MyButton(
            text: "下一步",
            onPressed: () {
              var code = codeC.text;
              if(code!=null&&code.length==4){
                NavigatorUtils.push(context, ShopRouter.REGISTER_THIRD,
                    params: {"tel": widget.tel, "code": codeC.text});
              }else{
                showToast("验证码格式不对");
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "用户注册-第二步");
  }
}
