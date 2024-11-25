import 'dart:developer';

import 'package:amazone_clone/admin/features/products/presentation/widgets/add_product_image.dart';
import 'package:amazone_clone/admin/features/products/presentation/widgets/show_snackbar.dart';
import 'package:amazone_clone/admin/features/products/presentation/widgets/text_field.dart';
import 'package:amazone_clone/admin/features/products/provider/add_prducti_provider.dart';
import 'package:amazone_clone/auth/presentation/widgets/auth_textfield.dart';
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
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addProductProivider = Provider.of<AddPrductiProvider>(context);
    final size = MediaQuery.of(context).size;
    addProductProivider.addListener(
      () {},
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
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
              WhiteSpaces.height10,
              GestureDetector(
                onTap: () {
                  // if (addProductProivider.imageState.status ==
                  //         StateStatuse.success &&
                  //     addProductProivider.imageState.data!.isNotEmpty) {
                  if (formKey.currentState!.validate()) {
                    log("add product");
                    addProductProivider.uploadProduct(
                        context: context,
                        price: double.parse(priceController.text.trim()),
                        description: descriptionController.text.trim(),
                        quantity: double.parse(quantityController.text.trim()),
                        images: [],
                        productName: nameController.text.trim());
                  }
                  // } else {
                  //   showSnakbar(context, "Image not added");
                  // }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.primeryColor4),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primeryColor2),
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
