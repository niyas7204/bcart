import 'dart:developer';

import 'package:amazone_clone/utils/colors.dart';
import 'package:amazone_clone/utils/sized_boxes.dart';
import 'package:amazone_clone/user/features/cart/provider/cart_provider.dart';
import 'package:amazone_clone/user/features/products/models/user_products_model.dart';
import 'package:amazone_clone/user/features/products/providers/user_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProudctDetails extends StatefulWidget {
  final ProductModel product;

  const ProudctDetails({super.key, required this.product});

  @override
  State<ProudctDetails> createState() => _ProudctDetailsState();
}

class _ProudctDetailsState extends State<ProudctDetails> {
  @override
  Widget build(BuildContext context) {
    UserProductsProvider userProductsProvider =
        Provider.of<UserProductsProvider>(
      context,
    );
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * .4,
                  // width: size.width * .9,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.product.images![0])),
                      borderRadius: BorderRadius.circular(8)),
                ),
                WhiteSpaces.height20,
                Text(
                  widget.product.name!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff113946)
                      //AppTheme.primeryColor4
                      ),
                ),
                Row(
                  children: [
                    Text(
                      "PRICE : ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff113946)
                          //AppTheme.primeryColor4
                          ),
                    ),
                    Text(
                      "\$${widget.product.price.toString()}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primeryColor4),
                    ),
                  ],
                ),
                Text(
                  widget.product.description!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                WhiteSpaces.height20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        CartProvider cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        cartProvider.addToCart(
                            producId: widget.product.productId!, itemCount: 1);
                        // log("add to cart  ${widget.product.productId!}");
                        // userProductsProvider.addToCart(
                        //    ;
                      },
                      child: Container(
                        color: AppTheme.primeryColor3,
                        height: 60,
                        width: (size.width - 30) / 2,
                        child: Center(
                          child: Text(
                            "Add To Cart",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff113946)
                                //AppTheme.primeryColor4
                                ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: AppTheme.primeryColor3,
                      height: 60,
                      width: (size.width - 30) / 2,
                      child: Center(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff113946)
                              //AppTheme.primeryColor4
                              ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
