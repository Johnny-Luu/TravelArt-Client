import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabbar;
  final Color color;

  SliverAppBarDelegate({required this.tabbar, required this.color});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color,
      child: tabbar,
    );
  }

  @override
  double get maxExtent => tabbar.preferredSize.height;

  @override
  double get minExtent => tabbar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
