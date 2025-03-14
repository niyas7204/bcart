import 'dart:developer';

import 'package:amazone_clone/utils/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/user/core/page_routes.dart';
import 'package:amazone_clone/user/features/products/presentation/widgets/products_card.dart';
import 'package:amazone_clone/user/features/products/providers/user_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DisplayProducts extends StatefulWidget {
  final String tittle;
  final String? categoryId;
  const DisplayProducts(
      {super.key, required this.tittle, required this.categoryId});

  @override
  State<DisplayProducts> createState() => _DisplayProductsState();
}

class _DisplayProductsState extends State<DisplayProducts> {
  @override
  void initState() {
    UserProductsProvider userProductsProvider =
        Provider.of<UserProductsProvider>(context, listen: false);
    if (widget.categoryId != null) {
      userProductsProvider.getProducts(
          query: null, category: widget.categoryId);
    } else {
      log('init id  null');
      userProductsProvider.allprodctsState.status != StateStatuse.success
          ? userProductsProvider.getProducts(query: null, category: null)
          : null;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.tittle),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, searchPageRoute());
                },
                child: Icon(
                  Icons.search_rounded,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<UserProductsProvider>(
              builder: (context, productProvider, child) {
                final productState = productProvider.allprodctsState;
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
                            itemBuilder: (context, index) => UserProductCard(
                                index: index,
                                productState: productState,
                                productProvider: productProvider),
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
      ),
    );
  }
}
