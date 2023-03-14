import 'package:flutterjdshop/exports.dart';
import 'package:flutter/material.dart';

import 'refresh_loadmore_widget.dart';


/// 封装下拉刷新与加载更多
@immutable
class LoadMoreChild extends HookWidget {
  const LoadMoreChild({
    Key? key,
    required this.child,
    this.loadMore,
    this.hasMore = false,
  }) : super(key: key);
  final LoadMoreCallback? loadMore;
  final bool hasMore;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final loadMoreFunc = useCallback(() async {
      //'loadMoreFunc=${isLoading.value}=hasMore=$hasMore'.devLog();
      if (loadMore == null) {
        return;
      }
      if (isLoading.value) {
        return;
      }
      if (!hasMore) {
        return;
      }
      isLoading.value = true;
      await loadMore?.call();
      isLoading.value = false;
    }, [hasMore]);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification note) {
        /// 确保是垂直方向滚动，且滑动至底部
        final metrics = note.metrics;
        if (metrics.pixels == metrics.maxScrollExtent &&
            metrics.axis == Axis.vertical &&
            metrics.atEdge) {
          loadMoreFunc();
        }
        return false;
      },
      child: Builder(
        builder: (context) {
          final list = [
            Expanded(child: child),
            Visibility(
              visible: isLoading.value,
              child: const FooterListWidget(),
            ),
          ];
          return Column(
            children: list,
          );
        },
      ),
    );
  }
}
