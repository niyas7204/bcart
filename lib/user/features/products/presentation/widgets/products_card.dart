import 'package:amazone_clone/utils/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/utils/sized_boxes.dart';
import 'package:amazone_clone/user/features/products/models/user_products_model.dart';
import 'package:amazone_clone/user/features/products/presentation/pages/proudct_details.dart';
import 'package:amazone_clone/user/features/products/providers/user_products_provider.dart';
import 'package:flutter/material.dart';

class UserProductCard extends StatelessWidget {
  const UserProductCard({
    super.key,
    required this.index,
    required this.productState,
    required this.productProvider,
  });
  final int index;
  final StateHandler<UserProductsListModel> productState;
  final UserProductsProvider productProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProudctDetails(
            product: productState.data!.products[index],
          ),
        ));
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          productState.data!.products[index].images![0])),
                  borderRadius: BorderRadius.circular(8)),
            ),
            WhiteSpaces.height5,
            Text(
              productState.data!.products[index].name!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.primeryColor5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$  ${productState.data!.products[index].price}",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primeryColor1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
