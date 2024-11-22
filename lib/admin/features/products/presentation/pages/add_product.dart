import 'package:amazone_clone/admin/features/products/models/product_model.dart';
import 'package:amazone_clone/admin/features/products/presentation/widgets/add_product_image.dart';
import 'package:amazone_clone/admin/features/products/presentation/widgets/text_field.dart';
import 'package:amazone_clone/admin/features/products/provider/add_prducti_provider.dart';
import 'package:amazone_clone/admin/features/products/service/add_product_service.dart';
import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddImage(),
              WhiteSpaces.height20,
              ProductTextField(
                  width: size.width,
                  controller: nameController,
                  hintText: "Product Name",
                  formKey: formKey,
                  maxLine: 1),
              WhiteSpaces.height20,
              ProductTextField(
                  width: size.width,
                  controller: nameController,
                  hintText: "Description",
                  formKey: formKey,
                  maxLine: 5),
              WhiteSpaces.height20,
              Row(
                children: [
                  ProductTextField(
                      width: (size.width / 2) - 20,
                      controller: nameController,
                      hintText: "Price",
                      formKey: formKey,
                      maxLine: 1),
                  WhiteSpaces.width20,
                  ProductTextField(
                      width: (size.width / 2) - 20,
                      controller: nameController,
                      hintText: "Qauntity",
                      formKey: formKey,
                      maxLine: 1),
                ],
              ),
              WhiteSpaces.height20,
              GestureDetector(
                onTap: () {
                  AddProductService.uploadProduct(
                      product: ProductModel(
                          name: "name",
                          description: "description",
                          price: 200,
                          quantity: 5,
                          images: ["images"],
                          sellerId: "1",
                          productId: "productId"));
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
