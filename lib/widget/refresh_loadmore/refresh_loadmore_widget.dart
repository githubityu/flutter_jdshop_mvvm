import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef LoadMoreCallback = Future<void> Function();

//普通的
class RefreshLoadMoreWidget extends HookWidget {
  const RefreshLoadMoreWidget(
      {required this.child,
      Key? key,
      this.headerSliver,
      this.loadMore,
      this.onRefresh,
      this.emptyWidget,
      this.isEmpty = false,
      this.hasMore = false})
      : super(key: key);
  final List<Widget>? headerSliver;
  final Widget child;
  final Widget? emptyWidget;
  final LoadMoreCallback? loadMore;
  final RefreshCallback? onRefresh;
  final bool hasMore;
  final bool? isEmpty;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final loadMoreFunc = useCallback(() async {
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

    Widget current = CustomScrollView(
      slivers: [
        if (headerSliver != null) ...headerSliver!,
        isEmpty ?? false
            ? SliverFillRemaining(
                child: Center(
                  child: emptyWidget,
                ),
              )
            : child,
        if (loadMore != null)
          SliverVisibility(
            visible: isLoading.value,
            sliver: const SliverToBoxAdapter(
              child: FooterListWidget(),
            ),
          )
      ],
    );
    if (loadMore != null) {
      current = NotificationListener(
        onNotification: (ScrollNotification note) {
          /// 确保是垂直方向滚动，且滑动至底部
          if (note.metrics.pixels == note.metrics.maxScrollExtent &&
              note.metrics.axis == Axis.vertical) {
            loadMoreFunc();
          }
          return false;
        },
        child: current,
      );
    }
    if (onRefresh != null) {
      current = RefreshIndicator(onRefresh: onRefresh!, child: current);
    }
    return current;
  }
}

class FooterListWidget extends StatelessWidget {
  const FooterListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
          SizedBox(width: 10),
          Text('loading')
        ],
      ),
    );
  }
}
