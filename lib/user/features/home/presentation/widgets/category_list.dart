import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:amazone_clone/user/features/home/providers/home_page_product_provider.dart';
import 'package:amazone_clone/user/features/products/presentation/pages/display_products.dart';
import 'package:amazone_clone/user/features/products/providers/user_products_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    HomePageProvider homePageProvider = Provider.of<HomePageProvider>(
      context,
    );
    UserProductsProvider userProductsProvider =
        Provider.of<UserProductsProvider>(
      context,
    );

    return Builder(
      builder: (context) {
        switch (homePageProvider.dashboardState.status) {
          case StateStatuse.success:
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount:
                  homePageProvider.dashboardState.data!.categories.length,
              separatorBuilder: (context, index) => WhiteSpaces.width10,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  userProductsProvider.getProducts(
                      query: 'f',
                      category: homePageProvider
                          .dashboardState.data!.categories[index].id);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => DisplayProducts(
                  //       tittle: homePageProvider
                  //           .dashboardState.data!.categories[index].name),
                  // ));
                },
                child: Column(
                  children: [
                    homePageProvider
                                .dashboardState.data!.categories[index].image !=
                            null
                        ? CircleAvatar(
                            radius: 35,
                            backgroundColor: AppTheme.primeryColor2,
                            backgroundImage: NetworkImage(homePageProvider
                                .dashboardState.data!.categories[index].image!),
                          )
                        : CircleAvatar(
                            radius: 35,
                            backgroundColor: AppTheme.primeryColor2,
                            child: Center(
                              child: Icon(Icons.shopify_rounded),
                            ),
                          ),
                    Text(
                      homePageProvider
                          .dashboardState.data!.categories[index].name,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          height: 0,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primeryColor5),
                    ),
                  ],
                ),
              ),
            );
          case StateStatuse.loading:
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, index) => WhiteSpaces.width10,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(.2),
                highlightColor: Colors.grey.withOpacity(.2),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: AppTheme.primeryColor2,
                    ),
                    Text(
                      "Category",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          height: 0,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primeryColor5),
                    ),
                  ],
                ),
              ),
            );

          default:
            return SizedBox();
        }
      },
    );
  }
}
