import 'dart:developer';

import 'package:amazone_clone/admin/features/products/provider/add_product_provider.dart';
import 'package:amazone_clone/utils/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDropdown extends StatefulWidget {
  final TextEditingController categoryController;

  const CategoryDropdown({
    super.key,
    required this.categoryController,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? currentCategory;
  @override
  void initState() {
    widget.categoryController.value = TextEditingValue(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProivider = Provider.of<ProductProvider>(context);
    productProivider.addListener(
      () {},
    );
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.primeryColor5),
        ),
        Container(
          height: 50,
          width: (size.width / 2) - 20,
          padding: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              // color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: AppTheme.primeryColor4,
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer)
              ],
              borderRadius: BorderRadius.circular(12)),
          child: DropdownButton(
            isExpanded: true,
            underline: const SizedBox(),
            focusColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            value: currentCategory,
            items:
                productProivider.catogerisState.status == StateStatuse.success
                    ? productProivider.catogerisState.data!.categories.map(
                        (category) {
                          return DropdownMenuItem(
                            value: category.name,
                            child: Text(category.name),
                            onTap: () {
                              setState(() {
                                currentCategory = category.name;
                                widget.categoryController.value =
                                    TextEditingValue(text: category.name);
                              });
                            },
                          );
                        },
                      ).toList()
                    : [],
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
