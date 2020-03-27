import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/api/model/void_modle.dart';
import 'package:flutterjdshop/api/model/void_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/config/user_info_data.dart';
import 'package:flutterjdshop/receiver/event_bus.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/res/styles.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/view/app_topbar.dart';
import 'package:flutterjdshop/widget/view/my_button.dart';
import 'package:flutterjdshop/widget/view/text_field.dart';

class AddressAddOrEdit extends StatefulWidget {
  final Map<String, List<String>> address;

  const AddressAddOrEdit({Key key, this.address}) : super(key: key);

  @override
  _AddressAddOrEditState createState() => _AddressAddOrEditState();
}

class _AddressAddOrEditState extends BasePageState<AddressAddOrEdit> {
  bool isEdit = false;
  bool _isClick = true;
  String area = '';
  String address = '';
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  FocusNode addressFN = new FocusNode();
  FocusNode phoneFN = new FocusNode();
  FocusNode nameFN = new FocusNode();

  @override
  Widget getAppBar(BuildContext context) {
    // TODO: implement getAppBar
    return CommonBackTopBar(
      title: isEdit ? "编辑地址" : "添加地址",
    );
  }

  verData() {
    bool isClick = false;
    var name = nameController.text;
    var phone = phoneController.text;
    var address = addressController.text;
    if (name.length > 0 &&
        phone.length == 11 &&
        address.length > 0 &&
        area.length > 0) {
      isClick = true;
    }
    if (_isClick != isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  @override
  void subInitState() {
    // TODO: implement subInitState
    isEdit = widget.address.keys.length > 0;
    if (isEdit) {
      nameController.text = widget.address["name"].first;
      phoneController.text = widget.address["phone"].first;
      addressController.text = widget.address["address"].first;
    }
    nameController.addListener(verData);
    phoneController.addListener(verData);
    addressController.addListener(verData);
  }

  @override
  Widget getBody(BuildContext context) {
    // TODO: implement getBody
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Gaps.vGap10,
          MyTextField(
            key: Key('name'),
            maxLength: 20,
            keyboardType: TextInputType.text,
            focusNode: nameFN,
            hintText: '收货人姓名',
            controller: nameController,
          ),
          Gaps.vGap10,
          MyTextField(
            key: Key('phone'),
            maxLength: 11,
            keyboardType: TextInputType.phone,
            focusNode: phoneFN,
            hintText: '收货人电话',
            controller: phoneController,
          ),
          Gaps.vGap10,
          Container(
            alignment: Alignment.centerLeft,
            height: AppSize.height(100),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: FlatButton.icon(
              padding: EdgeInsets.all(0),
              onPressed: () async {
                var result = await CityPickers.showCityPicker(
                    context: context, locationCode: "130102");
                setState(() {
                  this.area =
                      "${result.provinceName}/${result.cityName}/${result.areaName}";
                });
              },
              icon: Icon(Icons.add_location),
              label: Text(
                this.area.length > 0 ? "${this.area}" : "省/市/区",
                style: TextStyles.textBlack14,
              ),
            ),
          ),
          Gaps.vGap10,
          MyTextField(
            key: Key('address'),
            maxLength: 20,
            keyboardType: TextInputType.text,
            focusNode: addressFN,
            hintText: '详细地址',
            controller: addressController,
          ),
          Gaps.vGap10,
          MyButton(
            text: !isEdit ? "添加" : "编辑",
            onPressed: _isClick
                ? () {
                    if (area == null || area.isEmpty) {
                      showToast("请选择区域");
                      return;
                    }
                    var tempJson = {
                      "uid": UserInfoData.instance.id,
                      "name": nameController.text,
                      "phone": phoneController.text,
                      "address": "$area${addressController.text}",
                      "salt": UserInfoData.instance.salt
                    };
                    if (isEdit) {
                      tempJson["id"] = widget.address["id"].first;
                    }
                    var sign = getSign(tempJson);
                    if (isEdit) {
                      VoidViewModel.get(this, getCancelToken())
                          .getData(
                              type: VoidModel.EDIT_ADDRESS,
                              params2: tempJson..["sign"] = sign)
                          .then((onValue) {
                        eventBus.fire(RefreshAddressEvent());
                        Navigator.pop(context);
                      });
                    } else {
                      VoidViewModel.get(this, getCancelToken())
                          .getData(
                              type: VoidModel.ADD_ADDRESS,
                              params2: tempJson..["sign"] = sign)
                          .then((onValue) {
                        eventBus.fire(RefreshAddressEvent());
                        Navigator.pop(context);
                      });
                    }
                  }
                : null,
          )
        ],
      ),
    );
  }
}
