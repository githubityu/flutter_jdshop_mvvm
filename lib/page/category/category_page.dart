import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/api/model/CateModel.dart';
import 'package:flutterjdshop/api/model/cate_view_model.dart';
import 'package:flutterjdshop/base/base_page_state.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/utils/app_size.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/utils/view_utils.dart';
import 'package:flutterjdshop/widget/view/load_image.dart';
import 'package:flutterjdshop/widget/view/load_state_layout.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends BasePageState<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  LoadState _layoutState = LoadState.State_Loading;
  int _selectIndex = 0;
  List<CateItemModel> _leftCateList = [];
  List _rightCateList = [];

  @override
  void subInitState() {
    // TODO: implement subInitState
    _leftData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize.init(context);
    return getScaffold();
  }

  _leftData() {
    CateViewModel.get(getCancelToken()).getData().then((onValue) {
      setState(() {
        this._leftCateList = onValue.result;
        _layoutState = LoadState.State_Success;
      });
      if (_leftCateList != null && _leftCateList.isNotEmpty) {
        _rightData(onValue.result[0].sId);
      }
    });
  }


  _rightData(pid) {
    CateViewModel.get(getCancelToken(), view: this).getData(pid: pid, type: 1).then((onValue) {
      setState(() {
        this._rightCateList = onValue.result;
      });
    });
  }

  @override
  Widget getAppBar(BuildContext context) {
    return getSearchAppBar(context);
  }
  @override
  bool useMyAppBar() => false;

  @override
  Widget getBody(BuildContext context) {
    var leftWidth = AppSize.getWidth() / 4;
    var rightItemWidth =
        AppSize.width((AppSize.getWidth() - leftWidth - 40) / 3);
    var rightItemHeight = rightItemWidth + AppSize.height(28);
    return LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        //重新加载当前数据
      },
      successWidget: Row(
        children: <Widget>[
          _leftCateWidget(leftWidth),
          _rightCateWidget(rightItemWidth,rightItemHeight)
        ],
      ),
    );
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Color.fromRGBO(240, 246, 246, 0.9),
        child: GridView.builder(
            itemCount: _rightCateList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: rightItemWidth / rightItemHeight,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ExcludeSemantics(
                            child: LoadImage(
                                getFullPath(_rightCateList[index].pic),
                                width: AppSize.width(rightItemWidth),
                                height: AppSize.width(rightItemWidth)),
                          )),
                      Container(
                        height: AppSize.height(28),
                        child: Text("${this._rightCateList[index].title}"),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _leftCateWidget(leftWidth) {
    return Container(
      width: leftWidth,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    _selectIndex = index;
                  });
                  _rightData(_leftCateList[_selectIndex].sId);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                    border: Border(
                      left: BorderSide(color: _selectIndex == index
                          ?Colors.red:Colors.white,width: 5)
                    )
                  ),
                  height: AppSize.height(84),
                  padding: EdgeInsets.only(top: AppSize.height(24)),
                  child: Text(
                    "${this._leftCateList[index].title}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Gaps.line
            ],
          );
        },
        itemCount: _leftCateList.length,
      ),
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
