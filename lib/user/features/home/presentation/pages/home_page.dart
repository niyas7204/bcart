import 'dart:developer';

import 'package:amazone_clone/admin/features/products/provider/add_product_provider.dart';
import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/show_snackbar.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:amazone_clone/user/features/home/presentation/widgets/category_list.dart';
import 'package:amazone_clone/user/features/home/presentation/widgets/top_moving.dart';
import 'package:amazone_clone/user/features/home/providers/home_page_product_provider.dart';
import 'package:amazone_clone/user/features/products/presentation/pages/display_products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ["c-one", "c-two", "c-three"];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        HomePageProvider homepageProvider =
            Provider.of<HomePageProvider>(context, listen: false);
        if (homepageProvider.dashboardState.status != StateStatuse.success) {
          homepageProvider.getDashboard();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomePageProvider homePageProvider = Provider.of<HomePageProvider>(
      context,
    );

    // precacheImage(const AssetImage("assets/banner/banner.jpg"), context);
    final Size size = MediaQuery.of(context).size;
    return PopScope(
      child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Scaffold(
                backgroundColor: AppTheme.primeryColor2,
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      collapsedHeight: 70,
                      pinned: true,
                      shadowColor: Colors.white.withOpacity(0),
                      surfaceTintColor: AppTheme.primeryColor6,
                      foregroundColor: AppTheme.primeryColor6,
                      backgroundColor: AppTheme.primeryColor6,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        expandedTitleScale: 1,
                        collapseMode: CollapseMode.pin,
                        centerTitle: true,
                        title: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: AppTheme.primeryColor5,
                                    blurRadius: 3,
                                    blurStyle: BlurStyle.outer)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          width: size.width - 20,
                        ),
                        background: Container(
                          color: AppTheme.primeryColor2,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/banner/banner1.jpeg",
                              ),
                            )),
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                    // SliverPersistentHeader(
                    //     floating: true, pinned: true, delegate: CustomSearchBar()),
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primeryColor6,
                          // borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(30),
                          //     topRight: Radius.circular(30))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WhiteSpaces.height20,
                              Text(
                                "Categories",
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primeryColor5),
                              ),
                              WhiteSpaces.height10,
                              SizedBox(height: 100, child: CategoryList()),
                              WhiteSpaces.height20,
                              Text(
                                "Top Moving",
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primeryColor5),
                              ),
                              TopMovings(),
                              SizedBox(
                                height: 80,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ));
          }),
    );
  }
}
