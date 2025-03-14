import 'package:amazone_clone/utils/colors.dart';
import 'package:flutter/material.dart';

class ProductTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLine;
  final double width;
  // final GlobalKey<FormState> formKey;

  const ProductTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      // required this.formKey,
      required this.maxLine,
      required this.width});

  @override
  State<ProductTextField> createState() => _ProductTextFieldState();
}

class _ProductTextFieldState extends State<ProductTextField> {
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hintText,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.primeryColor5),
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: AppTheme.primeryColor4,
                          blurRadius: 3,
                          blurStyle: BlurStyle.outer)
                    ],
                    // border: Border.all(
                    //   width: .5,
                    //   color: AppTheme.primeryColor4,
                    // ),
                    borderRadius: BorderRadius.circular(12)),
                width: widget.width,
                height: 50,
              ),
              SizedBox(
                width: widget.width,
                height: 70,
                child: TextFormField(
                  clipBehavior: Clip.none,
                  keyboardType: widget.hintText == "Price" ||
                          widget.hintText == "Qauntity"
                      ? TextInputType.number
                      : TextInputType.text,
                  obscureText: isObscure,
                  maxLines: widget.maxLine,
                  cursorErrorColor: AppTheme.primeryColor5,
                  cursorColor: AppTheme.primeryColor5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      // setState(() {
                      //   errorMessage = ;
                      // });
                      return "${widget.hintText} is missing";
                    }
                    return null;
                  },
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    errorStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
