import 'package:amazone_clone/admin/features/products/models/products_model.dart';
import 'package:amazone_clone/admin/features/products/provider/add_product_provider.dart';
import 'package:amazone_clone/core/constants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/show_snackbar.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.index,
    required this.productState,
    required this.productProivider,
  });
  final int index;
  final StateHandler<ProductsListModel> productState;
  final ProductProvider productProivider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              IconButton(
                  onPressed: () async {
                    showConfirmation(
                        title: "Delete Product",
                        body: "Do You Want Delete The Product",
                        onConfirm: () {
                          productProivider.deleteProduct(
                              productId:
                                  productState.data!.products[index].productId!,
                              context: context);
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
    );
  }
}
