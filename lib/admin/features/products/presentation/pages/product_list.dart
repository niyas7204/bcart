import 'dart:developer';
import 'package:amazone_clone/admin/features/products/presentation/pages/add_product.dart';
import 'package:amazone_clone/admin/features/products/presentation/widgets/product_card.dart';
import 'package:amazone_clone/admin/features/products/provider/add_product_provider.dart';
import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
          child: Builder(
            builder: (context) {
              switch (productState.status) {
                case StateStatuse.loading:
                  return GridView.builder(
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
                          )));
                case StateStatuse.success:
                  return productState.data!.products.isNotEmpty
                      ? GridView.builder(
                          itemCount: productState.data!.products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1 / 1.5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) => ProductCard(
                              index: index,
                              productState: productState,
                              productProivider: productProivider),
                        )
                      : Center(
                          child: Stack(
                          children: [
                            SvgPicture.asset(
                                "assets/story_set/Empty-cuate.svg"),
                            Positioned(
                              bottom: 10,
                              child: SizedBox(
                                width: size.width - 30,
                                child: Center(
                                  child: Text(
                                    "Products Not Found",
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
                        ));
                case StateStatuse.error:
                  return Center(
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
                  ));
                default:
                  return SizedBox();
              }
            },
          )),
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
