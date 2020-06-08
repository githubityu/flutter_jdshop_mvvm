import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/api/model/void_modle.dart';
import 'package:flutterjdshop/api/model/void_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/receiver/event_bus.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';
import 'package:flutterjdshop/widget/view/text_field.dart';
import 'package:flutterjdshop/utils/log_utils.dart';
import 'package:rxdart/rxdart.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pwdC = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _pwdFN = FocusNode();

  @override
  void subInitState() {
    // TODO: implement subInitState
    _phoneController.addListener(_verData);
    _pwdC.addListener(_verData);
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      height: 500,
      padding: EdgeInsets.all(AppSize.width(20)),
      child: ListView(
        children: <Widget>[
          Gaps.vGap10,
          MyTextField(
            key: Key("phone"),
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            focusNode: _nodeText1,
            hintText: "请输入手机号",
          ),
          Gaps.vGap10,
          MyTextField(
            key: Key("pwd"),
            controller: _pwdC,
            isInputPwd: true,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 20,
            focusNode: _pwdFN,
            hintText: "请输入密码",
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.height(1)),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    child: Text('忘记密码'),
                    color: Colors.transparent,
                    onPressed: () {},
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text('新用户注册'),
                    color: Colors.transparent,
                    onPressed: () {
                      NavigatorUtils.push(context, ShopRouter.REGISTER_FIRST);
                    },
                  ),
                )
              ],
            ),
          ),
          MyButton(
            text: "登录",
            key: Key("login"),
            onPressed: _isClick
                ? () {
                    VoidViewModel.get(this, getCancelToken())
                        .getData(type: VoidModel.LOGIN, params2: {
                      "username": _phoneController.text,
                      "password": _pwdC.text,
                    }).then((onValue) {
                      var map =
                          (onValue as Map<String, dynamic>)["userinfo"][0];
                      UserInfoData.instance.userInfo = map;
                      Future.delayed(Duration(milliseconds:  200), () {
                        eventBus.fire(MineChangeEvent());
                        NavigatorUtils.pop(context);
                        Log.e("销毁页面");
                      });
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }

  bool _isClick = false;

  _verData() {
    bool isClick = true;
    var phone = _phoneController.text;
    var pwd = _pwdC.text;
    if (phone != null && phone.length == 11 && pwd != null && pwd.length > 5) {
      isClick = true;
    } else {
      isClick = false;
    }
    if (_isClick != isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(
      title: "登录",
    );
  }
}
