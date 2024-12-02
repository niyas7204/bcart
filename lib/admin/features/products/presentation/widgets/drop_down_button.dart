import 'package:amazone_clone/core/contants/colors.dart';
import 'package:flutter/material.dart';

class CategoryDropdown extends StatefulWidget {
  final TextEditingController categoryController;
  const CategoryDropdown({super.key, required this.categoryController});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String category = "One";
  @override
  void initState() {
    widget.categoryController.value = TextEditingValue(text: "One");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            value: category,
            items: [
              DropdownMenuItem(
                value: "One",
                child: const Text("One"),
                onTap: () {
                  setState(() {
                    category = "One";
                    widget.categoryController.value =
                        TextEditingValue(text: "One");
                  });
                },
              ),
              DropdownMenuItem(
                value: "Two",
                onTap: () {
                  setState(() {
                    category = "Two";
                    widget.categoryController.value =
                        TextEditingValue(text: "Two");
                  });
                },
                child: const Text("Two"),
              ),
              DropdownMenuItem(
                value: "Three",
                onTap: () {
                  setState(() {
                    category = "Three";
                    widget.categoryController.value =
                        TextEditingValue(text: "Three");
                  });
                },
                child: const Text("Three"),
              )
            ],
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
