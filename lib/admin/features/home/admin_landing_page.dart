import 'package:amazone_clone/admin/features/products/presentation/pages/product_list.dart';
import 'package:amazone_clone/core/contants/colors.dart';
 import 'package:amazone_clone/user/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class AdminLandingPage extends StatefulWidget {
  const AdminLandingPage({super.key});

  @override
  State<AdminLandingPage> createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {
  int currentIndex = 0;

  List<Widget> pages = [
    ProductList(),
    HomePage(),
    HomePage(),
  ];
  void updatePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
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
                    "Products",
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
                    Icons.shopping_bag_outlined,
                    size: 35,
                    color: currentIndex == 1
                        ? AppTheme.primeryColor5
                        : AppTheme.primeryColor5.withOpacity(.5),
                  ),
                  Text(
                    "Analatics",
                    style: TextStyle(
                        color: currentIndex == 1
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
                updatePage(2);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_2_outlined,
                    size: 35,
                    color: currentIndex == 2
                        ? AppTheme.primeryColor5
                        : AppTheme.primeryColor5.withOpacity(.5),
                  ),
                  Text(
                    "Inbox",
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
          ],
        ),
      ),
    );
  }
}
