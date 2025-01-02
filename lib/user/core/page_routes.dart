import 'package:amazone_clone/user/features/products/presentation/pages/search_product.dart';
import 'package:flutter/material.dart';

Route searchPageRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SearchProduct(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // const begin = Offset(1.0, 0.0);
      // const end = Offset.zero;
      // const curve = Curves.ease;
      // var tween = Tween(
      //   begin: begin,
      //   end: end,
      // ).chain(CurveTween(curve: curve));
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
