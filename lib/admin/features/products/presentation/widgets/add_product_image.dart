import 'package:amazone_clone/admin/features/products/provider/add_product_provider.dart';
import 'package:amazone_clone/core/constants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProivider = Provider.of<ProductProvider>(context);
    return productProivider.imageState.status == StateStatuse.success &&
            productProivider.imageState.data!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Product Image",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.primeryColor5),
                  ),
                  WhiteSpaces.width10,
                  CircleAvatar(
                    backgroundColor: AppTheme.primeryColor5,
                    radius: 10,
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              WhiteSpaces.height10,
              CarouselSlider(
                  items: productProivider.imageState.data!
                      .map(
                        (e) => Image.file(e),
                      )
                      .toList(),
                  options: CarouselOptions(viewportFraction: 1, height: 200)),
            ],
          )
        : GestureDetector(
            onTap: () {
              productProivider.selectImages();
            },
            child: DottedBorder(
                radius: Radius.circular(12),
                borderType: BorderType.RRect,
                color: AppTheme.primeryColor4,
                child: SizedBox(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image,
                            size: 50, color: AppTheme.primeryColor4),
                        WhiteSpaces.height10,
                        Text(
                          "Select Product Image",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppTheme.primeryColor4.withOpacity(.5)),
                        ),
                      ],
                    ),
                  ),
                )),
          );
  }
}
