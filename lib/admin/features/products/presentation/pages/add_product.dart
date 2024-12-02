import 'dart:developer';

import 'package:amazone_clone/admin/features/products/presentation/widgets/add_product_image.dart';
import 'package:amazone_clone/admin/features/products/presentation/widgets/drop_down_button.dart';
import 'package:amazone_clone/core/widgets/show_snackbar.dart';
import 'package:amazone_clone/admin/features/products/presentation/widgets/text_field.dart';
import 'package:amazone_clone/admin/features/products/provider/add_product_provider.dart';
<<<<<<< HEAD
=======
import 'package:amazone_clone/auth/presentation/widgets/auth_textfield.dart';
>>>>>>> origin/main
import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProivider = Provider.of<ProductProvider>(context);
    final size = MediaQuery.of(context).size;
    productProivider.addListener(
      () {
        if (productProivider.addproductState.status == StateStatuse.success) {
<<<<<<< HEAD
          log("===== ${productProivider.addproductState.status}");
          categoryController.clear();
=======
>>>>>>> origin/main
          nameController.clear();
          descriptionController.clear();
          priceController.clear();
          quantityController.clear();
          productProivider.setProduct = StateHandler.initial();
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: AddImage(),
              ),
              WhiteSpaces.height20,
              ProductTextField(
                  width: size.width,
                  controller: nameController,
                  hintText: "Product Name",
                  formKey: formKey,
                  maxLine: 1),
              ProductTextField(
                  width: size.width,
                  controller: descriptionController,
                  hintText: "Description",
                  formKey: formKey,
                  maxLine: 5),
              Row(
                children: [
                  ProductTextField(
                      width: (size.width / 2) - 20,
                      controller: priceController,
                      hintText: "Price",
                      formKey: formKey,
                      maxLine: 1),
                  ProductTextField(
                      width: (size.width / 2) - 20,
                      controller: quantityController,
                      hintText: "Qauntity",
                      formKey: formKey,
                      maxLine: 1),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CategoryDropdown(
                  categoryController: categoryController,
                ),
              ),
              WhiteSpaces.height10,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  onTap: () {
                    if (productProivider.imageState.status ==
                            StateStatuse.success &&
                        productProivider.imageState.data!.isNotEmpty &&
                        productProivider.addproductState.status !=
                            StateStatuse.loading) {
                      if (formKey.currentState!.validate()) {
                        log("add product");
                        productProivider.uploadProduct(
                            context: context,
<<<<<<< HEAD
                            category: categoryController.text,
=======
>>>>>>> origin/main
                            price: double.parse(priceController.text.trim()),
                            description: descriptionController.text.trim(),
                            quantity:
                                double.parse(quantityController.text.trim()),
                            images: productProivider.imageState.data!,
                            productName: nameController.text.trim());
                      }
                    } else {
                      showSnakbar(context, "Image not added");
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppTheme.primeryColor4),
                    child: Center(
                      child: productProivider.addproductState.status ==
                              StateStatuse.loading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primeryColor2),
                            ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
