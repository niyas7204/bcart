import 'package:amazone_clone/admin/features/products/presentation/pages/add_product.dart';
import 'package:amazone_clone/core/contants/colors.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2),
          itemBuilder: (context, index) => Container(
            color: AppTheme.primeryColor5,
            width: 50,
            height: 100,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddProduct(),
          ));
        },
        backgroundColor: AppTheme.primeryColor2,
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
