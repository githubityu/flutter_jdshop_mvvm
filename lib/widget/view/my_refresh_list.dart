
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjdshop/res/gaps.dart';
import 'package:flutterjdshop/res/styles.dart';
import 'package:flutterjdshop/utils/theme_utils.dart';

import 'load_state_layout.dart';


/// 封装下拉刷新与加载更多
class DeerListView extends StatefulWidget {

  const DeerListView({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.onRefresh,
    this.loadMore,
    this.hasMore : false,
    this.stateType : LoadState.State_Empty,
    this.pageSize : 10,
    this.padding,
    this.itemExtent,
  }): super(key: key);

  final RefreshCallback onRefresh;
  final LoadMoreCallback loadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final LoadState stateType;
  /// 一页的数量，默认为10
  final int pageSize;
  /// padding属性使用时注意会破坏原有的SafeArea，需要自行计算bottom大小
  final EdgeInsetsGeometry padding;
  final double itemExtent;

  @override
  _DeerListViewState createState() => _DeerListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _DeerListViewState extends State<DeerListView> {

  /// 是否正在加载数据
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener(
        onNotification: (ScrollNotification note) {
          /// 确保是垂直方向滚动，且滑动至底部
          if (note.metrics.pixels == note.metrics.maxScrollExtent && note.metrics.axis == Axis.vertical) {
            _loadMore();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: widget.itemCount == 0 ? LoadStateLayout(state: widget.stateType) : ListView.builder(
            itemCount: widget.loadMore == null ? widget.itemCount : widget.itemCount + 1,
            padding: widget.padding,
            itemExtent: widget.itemExtent,
            itemBuilder: (BuildContext context, int index) {
              /// 不需要加载更多则不需要添加FootView
              if (widget.loadMore == null) {
                return widget.itemBuilder(context, index);
              } else {
                return index < widget.itemCount ? widget.itemBuilder(context, index) : MoreWidget(widget.itemCount, widget.hasMore, widget.pageSize);
              }
            }
          )
        ),
      ),
    );
  }

  Future _loadMore() async {
    if (widget.loadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }
    if (!widget.hasMore) {
      return;
    }
    _isLoading = true;
    await widget.loadMore();
    _isLoading = false;
  }

}

class MoreWidget extends StatelessWidget {
  
  const MoreWidget(this.itemCount, this.hasMore, this.pageSize);

  final int itemCount;
  final bool hasMore;
  final int pageSize;
  
  @override
  Widget build(BuildContext context) {
    final style = ThemeUtils.isDark(context) ? TextStyles.textGray14 : const TextStyle(color: Color(0x8A000000));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          hasMore ? const CupertinoActivityIndicator() : Gaps.empty,
          hasMore ? Gaps.hGap5 : Gaps.empty,
          /// 只有一页的时候，就不显示FooterView了
          Text(hasMore ? '正在加载中...' : (itemCount < pageSize ? '' : '没有了呦~'), style: style),
        ],
      ),
    );
  }
}

