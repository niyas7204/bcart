import 'dart:developer';

import 'package:amazone_clone/admin/features/products/presentation/pages/add_product.dart';
import 'package:amazone_clone/admin/features/products/provider/add_product_provider.dart';
import 'package:amazone_clone/auth/provider/user_provider.dart';
import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final productProivider =
            Provider.of<ProductProvider>(context, listen: false);
        productProivider.getProduct();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProivider = Provider.of<ProductProvider>(context);
    final productState = productProivider.getproductState;
    productProivider.addListener(
      () {
        log("======= ${productProivider.getproductState.status}");
      },
    );
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: productState.status == StateStatuse.loading
              ? Center(child: CircularProgressIndicator())
              : productState.status == StateStatuse.success
                  ? GridView.builder(
                      itemCount: productState.data!.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1.2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(productState
                                    .data!.products[index].images[0])),
                            borderRadius: BorderRadius.circular(12)),
                        width: 50,
                        height: 100,
                      ),
                    )
                  : SizedBox()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddProduct(),
          ));
        },
        backgroundColor: AppTheme.primeryColor2,
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
