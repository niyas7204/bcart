import 'dart:developer';

import 'package:amazone_clone/admin/features/products/presentation/pages/product_list.dart';
import 'package:amazone_clone/auth/controller/provider/user_provider.dart';
import 'package:amazone_clone/utils/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/utils/sized_boxes.dart';
import 'package:amazone_clone/auth/presentation/widgets/auth_button.dart';
import 'package:amazone_clone/auth/presentation/widgets/auth_textfield.dart';
import 'package:amazone_clone/user/features/home/presentation/pages/home_page.dart';
import 'package:amazone_clone/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mobileController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    log("login page init");
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     final UserProvider authProvider =
    //         Provider.of<UserProvider>(context, listen: false);
    //     authProvider.setUser = StateHandler.initial();
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<UserProvider>(context);
    authProvider.addListener(
      () {
        if (authProvider.user.status == StateStatuse.success) {
          authProvider.user.data!.user.userType == "admin"
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductList(),
                  ))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
          authProvider.setUser = StateHandler.initial();
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello !",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primeryColor1),
              ),
              Text(
                "Sign in to continue",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondaryTextColor),
              ),
              WhiteSpaces.height20,
              AuthField(
                controller: _mobileController,
                formKey: formKey,
              ),
              WhiteSpaces.height10,
              authProvider.user.status == StateStatuse.error
                  ? Text(
                      authProvider.user.errorMessage!,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  : WhiteSpaces.empty,
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You will get an OTP to this number",
                      style: AppTextStyle.hintTextStyle,
                    ),
                    WhiteSpaces.height20,
                    WhiteSpaces.height20,
                    AuhtButton(
                      formKey: formKey,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // authProvider.userSignin(
                          //     email: emailController.text.trim(),
                          //     password: passwordController.text.trim());
                        }
                      },
                      isLogin: true,
                    ),
                    WhiteSpaces.height10,
                    Text(
                      "Continue without login",
                      style: AppTextStyle.primeryText20,
                    ),
                  ],
                ),
              ),
              WhiteSpaces.height20,
            ],
          ),
        ),
      )),
    );
  }
}
