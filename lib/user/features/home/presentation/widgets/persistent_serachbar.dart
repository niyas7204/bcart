import 'dart:developer';

import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/user/core/page_routes.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: () {
        log("on tap");
        Navigator.push(context, searchPageRoute());
      },
      child: Container(
        margin: EdgeInsets.all(12),
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppTheme.primeryColor5,
                  blurRadius: 3,
                  spreadRadius: 5,
                  blurStyle: BlurStyle.outer)
            ],
            color: AppTheme.primeryColor5,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
