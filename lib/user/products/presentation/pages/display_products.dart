import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/show_snackbar.dart';

class DisplayProducts extends StatefulWidget {
  final String tittle;
  const DisplayProducts({super.key, required this.tittle});

  @override
  State<DisplayProducts> createState() => _DisplayProductsState();
}

class _DisplayProductsState extends State<DisplayProducts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Products"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GridView.builder(
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
            ],
          ),
        ),
      ),
    );
  }
}
