import 'package:flutter/material.dart';
import 'package:flutterjdshop/api/model/void_modle.dart';
import 'package:flutterjdshop/api/model/void_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/dialog_utils.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';
import 'package:flutterjdshop/widget/view/text_field.dart';
import 'package:rxdart/rxdart.dart';

class RegisterThird extends StatefulWidget {
  String tel;
  String code;

  RegisterThird(this.tel, this.code);

  @override
  _RegisterThirdState createState() => _RegisterThirdState();
}

class _RegisterThirdState extends BasePageState<RegisterThird> {
  TextEditingController tc1 = TextEditingController();
  TextEditingController tc2 = TextEditingController();
  FocusNode fn1 = FocusNode();
  FocusNode fn2 = FocusNode();

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      padding: EdgeInsets.all(AppSize.width(20)),
      child: ListView(
        children: <Widget>[
          Gaps.vGap50,
          MyTextField(
            key: Key("password"),
            controller: tc1,
            focusNode: fn1,
            hintText: "请输入密码",
            isInputPwd: true,
            maxLength: 20,
            keyboardType: TextInputType.visiblePassword,
          ),
          Gaps.vGap10,
          MyTextField(
            key: Key("password2"),
            controller: tc2,
            focusNode: fn2,
            hintText: "请再次输入密码",
            isInputPwd: true,
            maxLength: 20,
            keyboardType: TextInputType.visiblePassword,
          ),
          Gaps.vGap10,
          MyButton(
            text: "下一步",
            onPressed: () {
              var pwd1 = tc1.text;
              var pwd2 = tc2.text;
              if (pwd1.length < 6) {
                showToast("密码长度不能小于6位");
                return;
              }
              if (pwd1 != pwd2) {
                showToast("密码和确认密码不一致");
                return;
              }
              VoidViewModel.get(this, getCancelToken()).getData(
                  type: VoidModel.REGISTER,
                  params2: {
                    "tel": widget.tel,
                    "code": widget.code,
                    "password": pwd1
                  }).then((onValue) {
                var map = (onValue as Map<String, dynamic>)["userinfo"][0];
                UserInfoData.instance.userInfo =map;
                NavigatorUtils.goRootPage(context);
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "用户注册-第三步");
  }
}
