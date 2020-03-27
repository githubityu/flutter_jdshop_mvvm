import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterjdshop/api/model/list_view_model.dart';
import 'package:flutterjdshop/api/model/void_modle.dart';
import 'package:flutterjdshop/api/model/void_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/receiver/event_bus.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/routes/fluro_navigator.dart';
import 'package:flutterjdshop/routes/shop_router.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/dialog/remind_dialog.dart';
import 'package:flutterjdshop/widget/view/load_state_layout.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends BasePageState<AddressList> {
  List addressList = [];
  LoadState _state = LoadState.State_Loading;
  final SlidableController slidableController = SlidableController();

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(title: "地址表");
  }

  StreamSubscription listen;
  BuildContext myContext;

  @override
  void subInitState() {
    // TODO: implement subInitState
    listen = eventBus.on<RefreshAddressEvent>().listen((onData) {
      _getAddressList();
    });
    _getAddressList();
  }

  _getAddressList() {
    var tempJson = {
      "uid": UserInfoData.instance.id,
      "salt": UserInfoData.instance.salt
    };
    ListViewModel.get(null, getCancelToken()).getData(
        type: VoidModel.ADDRESS_LIST,
        params2: {
          "uid": UserInfoData.instance.id,
          "sign": getSign(tempJson)
        }).then((data) {
      setState(() {
        _state = LoadState.State_Success;
        this.addressList = data;
      });
    });
  }

  _showDeleteDialog(id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => RemindDialog(
              content: "您确定要删除吗",
              confirmFunc: () {
                _deleteAddress(id);
              },
            ));
  }

  _deleteAddress(id) {
    var tempJson = {
      "uid": UserInfoData.instance.id,
      "id": id,
      "salt": UserInfoData.instance.salt
    };
    VoidViewModel.get(this, getCancelToken()).getData(
        type: VoidModel.DELETE_ADDRESS,
        params2: {
          "uid": UserInfoData.instance.id,
          "id": id,
          "sign": getSign(tempJson)
        }).then((data) {
      setState(() {
        NavigatorUtils.pop(context);
        _getAddressList();
      });
    });
  }

  _changeDefaultAddress(id) {
    var tempJson = {
      "uid": UserInfoData.instance.id,
      "id": id,
      "salt": UserInfoData.instance.salt
    };
    VoidViewModel.get(this, getCancelToken()).getData(
        type: VoidModel.CHANGE_ADDRESS,
        params2: {
          "uid": UserInfoData.instance.id,
          "id": id,
          "sign": getSign(tempJson)
        }).then((data) {
      setState(() {
        _getAddressList();
      });
    });
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return LoadStateLayout(
      state: _state,
      successWidget: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: AppSize.height(100)),
              child: ListView.builder(
                  itemCount: this.addressList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                        controller: slidableController,
                        key: Key("$index"),
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: '移除',
                            color: Colors.red,
                            icon: Icons.delete,
                            closeOnTap: true,
                            onTap: () {
                              _showDeleteDialog(this.addressList[index]["_id"]);
                            },
                          ),
                        ],
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              NavigatorUtils.push(
                                  context, ShopRouter.ADDRESS_ADDOREDIT,
                                  params: {
                                    "name": this.addressList[index]["name"],
                                    "phone": this.addressList[index]["phone"],
                                    "address": this.addressList[index]
                                        ["address"],
                                    "id": this.addressList[index]["_id"],
                                  });
                            },
                          ),
                          contentPadding: EdgeInsets.only(top: 20),
                          leading: isDefaultAddress(index)
                              ? Icon(Icons.check, color: Colors.red)
                              : null,
                          title: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${this.addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                                Gaps.vGap10,
                                Text("${this.addressList[index]["address"]}"),
                              ],
                            ),
                            onTap: () {
                              _changeDefaultAddress(this.addressList[index]["_id"]);
                            },
                          ),
                        ));
                  }),
            ),
            Positioned(
                child: Builder(
                  builder: (context){
                   return MyButton(
                      margin: EdgeInsets.all(10),
                      text: "增加收货地址",
                      onPressed: () {
                        if(slidableController.activeState!=null){
                          slidableController.activeState.close();
                        }
                        NavigatorUtils.push(context, ShopRouter.ADDRESS_ADDOREDIT);
                      },
                    );
                  },
                ),
                bottom: 0,
                width: AppSize.width(750),
                height: AppSize.height(110)),
          ],
        ),
      ),
    );
  }

  bool isDefaultAddress(index) {
    return this.addressList[index]["default_address"] == 1;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listen?.cancel();
    super.dispose();
  }
}
