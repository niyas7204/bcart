import 'package:amazone_clone/core/contants/colors.dart';
import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final GlobalKey<FormState> formKey;

  const AuthField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.formKey});

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool isObscure = false;
  @override
  void initState() {
    isObscure = widget.hintText == "Password";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: TextFormField(
        keyboardType: widget.hintText == "Email"
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText: isObscure,
        cursorErrorColor: AppTheme.primeryColor5,
        cursorColor: AppTheme.primeryColor5,
        validator: (value) {
          if (value!.isEmpty) {
            return "${widget.hintText} is missing";
          }
          return null;
        },
        controller: widget.controller,
        decoration: const InputDecoration(
            errorStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                )),
            fillColor: Color(0xFFeaeded),
            filled: true),
      ),
    );
  }
}
