import 'dart:developer';

import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/widgets/show_snackbar.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:amazone_clone/user/products/presentation/pages/display_products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ["c-one", "c-two", "c-three"];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // precacheImage(const AssetImage("assets/banner/banner.jpg"), context);
    final Size size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (didPop) {
        log("pop invoked");
      },
      child: Scaffold(
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
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            separatorBuilder: (context, index) =>
                                WhiteSpaces.width10,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DisplayProducts(
                                      tittle: categories[index]),
                                ));
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundColor: AppTheme.primeryColor2,
                                  ),
                                  Text(
                                    categories[index],
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        height: 0,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.primeryColor5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        WhiteSpaces.height20,
                        Text(
                          "Top Moving",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primeryColor5),
                        ),
                        SizedBox(
                          width: size.width,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 4,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                        color: Colors.grey.withOpacity(.2),
                                        // image: DecorationImage(
                                        //     fit: BoxFit.cover,
                                        //     image: NetworkImage(
                                        //         productState.data!.products[index].images[0])
                                        //         ),
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  WhiteSpaces.height5,
                                  Text(
                                    "product name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.primeryColor5),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$ price",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.primeryColor1),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            showConfirmation(
                                                title: "Delete Product",
                                                body:
                                                    "Do You Want Delete The Product",
                                                onConfirm: () {
                                                  // productProivider.deleteProduct(
                                                  //     productId:
                                                  //         productState.data!.products[index].productId!,
                                                  //     context: context);
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
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
