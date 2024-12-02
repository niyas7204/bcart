import 'dart:developer';

import 'package:amazone_clone/admin/features/products/presentation/pages/add_product.dart';
import 'package:amazone_clone/admin/features/products/provider/add_product_provider.dart';
import 'package:amazone_clone/admin/features/products/service/add_product_service.dart';
import 'package:amazone_clone/auth/provider/user_provider.dart';
import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/contants/key.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/show_snackbar.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

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
    final Size size = MediaQuery.of(context).size;
    final productProivider = Provider.of<ProductProvider>(context);
    final productState = productProivider.getproductState;
    productProivider.addListener(
      () {
        log("======= ${productProivider.getproductState.status}");
      },
    );
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      //AppTheme.primeryColor6,
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: productState.status == StateStatuse.loading
            ? GridView.builder(
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 68, 68, 68),
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(8)),
                    )))
            : productState.status == StateStatuse.success
                ? GridView.builder(
                    itemCount: productState.data!.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) => SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(productState
                                        .data!.products[index].images[0])),
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          WhiteSpaces.height5,
                          Text(
                            productState.data!.products[index].name,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primeryColor5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$  ${productState.data!.products[index].price}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primeryColor1),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    showConfirmation(
                                        title: "Delete Product",
                                        body: "Do You Want Delete The Product",
                                        onConfirm: () {
                                          productProivider.deleteProduct(
                                              productId: productState.data!
                                                  .products[index].productId!,
                                              context: context);
                                          Navigator.pop(context);
                                        },
                                        onCancel: () {
                                          Navigator.pop(context);
                                        },
                                        context: context);
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : productState.status == StateStatuse.error
                    ? Center(
                        child: Stack(
                        children: [
                          SvgPicture.asset("assets/story_set/failure.svg"),
                          Positioned(
                            bottom: 10,
                            child: SizedBox(
                              width: size.width - 30,
                              child: Center(
                                child: Text(
                                  "Something Went Wrong",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.aBeeZee(
                                      color: AppTheme.primeryColor4,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                    : SizedBox(),
      ),
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
