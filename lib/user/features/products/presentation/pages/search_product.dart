import 'dart:developer';

import 'package:amazone_clone/core/constants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/helpers/debouncer.dart';
import 'package:amazone_clone/user/features/products/presentation/widgets/products_card.dart';
import 'package:amazone_clone/user/features/products/providers/user_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final debouncer = Debouncer(milliseconds: 2000);
  @override
  void initState() {
    UserProductsProvider userProductsProvider =
        Provider.of<UserProductsProvider>(context, listen: false);
    userProductsProvider.allprodctsState.status != StateStatuse.success
        ? userProductsProvider.getProducts(query: "", category: null)
        : null;
    super.initState();
  }

  @override
  void deactivate() {
    UserProductsProvider userProductsProvider =
        Provider.of<UserProductsProvider>(context, listen: false);
    userProductsProvider.getProducts(query: "", category: null);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    UserProductsProvider userProductsProvider =
        Provider.of<UserProductsProvider>(
      context,
    );
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppTheme.primeryColor2,
        appBar: AppBar(
            leadingWidth: 30,
            backgroundColor: AppTheme.primeryColor2,
            title: Container(
              width: size.width,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: AppTheme.primeryColor5,
                        blurRadius: 3,
                        spreadRadius: 5,
                        blurStyle: BlurStyle.outer)
                  ],
                  color: AppTheme.primeryColor2,
                  borderRadius: BorderRadius.circular(12)),
              height: 40,
              child: Center(
                child: TextField(
                  focusNode: FocusNode(),
                  onChanged: (value) {
                    debouncer.run(
                      () {
                        userProductsProvider.getProducts(
                            query: value, category: null);
                      },
                    );
                  },
                  keyboardType: TextInputType.name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                  clipBehavior: Clip.none,
                  cursorErrorColor: AppTheme.primeryColor5,
                  cursorColor: AppTheme.primeryColor5,
                  decoration: const InputDecoration(
                    hintText: "search",
                    border: InputBorder.none,
                  ),
                ),
              ),
            )),
        body: Padding(
            padding: EdgeInsets.all(12),
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
            )));
  }
}
