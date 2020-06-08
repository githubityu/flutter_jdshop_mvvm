import 'package:flutter/cupertino.dart';
import 'package:flutterjdshop/api/model/void_modle.dart';
import 'package:flutterjdshop/api/model/void_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/my_navigator_observer.dart';
import 'package:flutterjdshop/routes/routers.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/log_utils.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';
import 'package:flutterjdshop/widget/view/text_field.dart';
import 'package:rxdart/rxdart.dart';

class RegisterFirst extends StatefulWidget {
  @override
  _RegisterFirstState createState() => _RegisterFirstState();
}

class _RegisterFirstState extends BasePageState<RegisterFirst> {
  TextEditingController phoneController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      padding: EdgeInsets.all(AppSize.width(20)),
      child: ListView(
        children: <Widget>[
          Gaps.vGap50,
          MyTextField(
            key: Key("phone"),
            controller: phoneController,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            focusNode: _nodeText1,
            hintText: "请输入手机号",
          ),
          MyButton(
            text: "下一步",
            onPressed: () {
              var phone = phoneController.text;
              if (phone.isNotEmpty && phone.length == 11) {
                VoidViewModel.get(this, getCancelToken()).getData(
                    type: VoidModel.SEND_CODE,
                    params2: {"tel": phone}).then((onValue) {
                  NavigatorUtils.push(context, ShopRouter.REGISTER_SECOND,
                      params: {"tel": phone});
                });
              } else {
                showToast("手机号格式不对");
                NavigatorUtils.removeRouteByName(context,ShopRouter.LOGIN);
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
    return CommonBackTopBar(
      title: "用户注册-第一步",
    );
  }
}
