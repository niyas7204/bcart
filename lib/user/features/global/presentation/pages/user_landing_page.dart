import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/user/features/home/presentation/pages/home_page.dart';
import 'package:amazone_clone/user/features/products/presentation/pages/display_products.dart';
import 'package:amazone_clone/user/profile/presentation/pages/pofile.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;

  List<Widget> pages = [
    HomePage(),
    DisplayProducts(
      tittle: "Products",
      categoryId: null,
    ),
    HomePage(),
    UserProfile(),
  ];
  void updatePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.primeryColor6,
        body: pages[currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.primeryColor2,
          ),
          height: 70,
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  updatePage(0);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 35,
                      color: currentIndex == 0
                          ? AppTheme.primeryColor5
                          : AppTheme.primeryColor5.withOpacity(.5),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 0,
                        color: currentIndex == 0
                            ? AppTheme.primeryColor5
                            : AppTheme.primeryColor5.withOpacity(.5),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  updatePage(1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopify_sharp,
                      size: 35,
                      color: currentIndex == 1
                          ? AppTheme.primeryColor5
                          : AppTheme.primeryColor5.withOpacity(.5),
                    ),
                    Text(
                      "explore",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 0,
                        color: currentIndex == 1
                            ? AppTheme.primeryColor5
                            : AppTheme.primeryColor5.withOpacity(.5),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  updatePage(2);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 35,
                      color: currentIndex == 2
                          ? AppTheme.primeryColor5
                          : AppTheme.primeryColor5.withOpacity(.5),
                    ),
                    Text(
                      "Cart",
                      style: TextStyle(
                          color: currentIndex == 2
                              ? AppTheme.primeryColor5
                              : AppTheme.primeryColor5.withOpacity(.5),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 0),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  updatePage(3);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_2_outlined,
                      size: 35,
                      color: currentIndex == 3
                          ? AppTheme.primeryColor5
                          : AppTheme.primeryColor5.withOpacity(.5),
                    ),
                    Text(
                      "Account",
                      style: TextStyle(
                          color: currentIndex == 3
                              ? AppTheme.primeryColor5
                              : AppTheme.primeryColor5.withOpacity(.5),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
