import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef OnRefresh(int pageNo);
typedef OnLoadMore(int pageNo);

class SimpleSmartRefresher extends StatefulWidget {
  final Widget child;
  final Widget? header;
  final Widget? footer;
  final bool enablePullUp;
  final bool enablePullDown;
  final OnRefresh? onRefresh;
  final OnLoadMore? onLoadMore;
  final int totalPage;
  final int pageNo;

  const SimpleSmartRefresher({
    Key? key,
    required this.child,
    this.header,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.onRefresh,
    this.onLoadMore,
    this.footer,
    this.totalPage = 1,
    this.pageNo = 1,
  }) : assert(child != null), super(key: key);

  @override
  _SimpleSmartRefresherState createState() => _SimpleSmartRefresherState();
}

class _SimpleSmartRefresherState extends State<SimpleSmartRefresher> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int _pageNo = 1;


  @override
  void initState() {
    super.initState();
    _pageNo = widget.pageNo;
  }

  _onRefresh() async{
    _pageNo = 1;
    await widget.onRefresh?.call(_pageNo);
    _refreshController.refreshCompleted();
  }

  _onLoadMore() async{
    if (_pageNo < widget.totalPage) {
      _pageNo ++;
      await widget.onLoadMore?.call(_pageNo);
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    _refreshController.resetNoData();
    return SmartRefresher(
      enablePullUp: widget.enablePullUp,
      enablePullDown: widget.enablePullDown,
      controller: _refreshController,
      onRefresh: () => _onRefresh(),
      onLoading: () => _onLoadMore(),
      child: widget.child,
      header: widget.header,
    );
  }
}
