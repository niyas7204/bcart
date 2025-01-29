import 'package:amazone_clone/core/constants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/show_snackbar.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:amazone_clone/user/features/home/providers/home_page_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TopMovings extends StatefulWidget {
  const TopMovings({super.key});

  @override
  State<TopMovings> createState() => _TopMovingsState();
}

class _TopMovingsState extends State<TopMovings> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    HomePageProvider homePageProvider = Provider.of<HomePageProvider>(
      context,
    );
    return Builder(
      builder: (context) {
        switch (homePageProvider.dashboardState.status) {
          case StateStatuse.loading:
            return SizedBox(
              width: size.width,
              child: Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.grey,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
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
                              color: Colors.grey.withOpacity(.2),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      body: "Do You Want Delete The Product",
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
            );
          case StateStatuse.success:
            return homePageProvider.dashboardState.data!.topMoving.isNotEmpty
                ? SizedBox(
                    width: size.width,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
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
                                  color: Colors.grey.withOpacity(.2),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  )
                : Center(
                    child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/story_set/Empty-cuate.svg",
                        height: size.height * .4,
                      ),
                      Positioned(
                        bottom: 0,
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

          case StateHandler.error:
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
    );
  }
}
