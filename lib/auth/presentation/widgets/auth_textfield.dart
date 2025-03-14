import 'package:amazone_clone/utils/colors.dart';
import 'package:amazone_clone/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;

  final GlobalKey<FormState> formKey;

  const AuthField({super.key, required this.controller, required this.formKey});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: widget.formKey,
      child: TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: AppTheme.primeryColor1,
        cursorErrorColor: AppTheme.primeryColor1,
        controller: widget.controller,
        style: AppTextStyle.inputTextStyle,
        decoration: InputDecoration(
          errorStyle: GoogleFonts.redHatText(
            color: Colors.red.withValues(alpha: .7),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: Colors.grey.withValues(alpha: .2),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                10,
              )),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "+91",
              style: AppTextStyle.hintTextStyle,
            ),
          ),
          hintText: "Enter Mobile Number",
          prefixIconConstraints: BoxConstraints(maxHeight: 44, maxWidth: 60),
          hintStyle: AppTextStyle.hintTextStyle,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your Mobile Number";
          } else if (value.length != 10 ||
              !RegExp(r'^[0-9]+$').hasMatch(value)) {
            return 'Enter a valid Mobile Number';
          }
          return null;
        },
      ),
    );
  }
}
