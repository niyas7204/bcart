import 'dart:developer';

import 'package:amazone_clone/admin/features/products/presentation/pages/product_list.dart';
import 'package:amazone_clone/auth/provider/user_provider.dart';
import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:amazone_clone/auth/presentation/pages/signup_page.dart';
import 'package:amazone_clone/auth/presentation/widgets/auth_button.dart';
import 'package:amazone_clone/auth/presentation/widgets/auth_textfield.dart';
import 'package:amazone_clone/user/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
  void dispose() {
    emailController.dispose();

    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    authProvider.addListener(
      () {
        log("auth service status ${authProvider.user.status}");
        if (authProvider.user.status == StateStatuse.success) {
          emailController.clear();
          log("========= ${authProvider.user.data!.user.userType}");
          passwordController.clear();

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign In.",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.primeryColor1,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                AuthField(
                  controller: emailController,
                  hintText: "Email",
                  formKey: formKey,
                ),
                WhiteSpaces.height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.primeryColor1,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                AuthField(
                  controller: passwordController,
                  hintText: "Password",
                  formKey: formKey,
                ),
                authProvider.user.status == StateStatuse.error
                    ? Text(
                        authProvider.user.errorMessage!,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    : WhiteSpaces.empty,
                WhiteSpaces.height20,
                AuhtButton(
                  formKey: formKey,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      authProvider.userSignin(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                    }
                  },
                  isLogin: true,
                ),
                WhiteSpaces.height20,
                GestureDetector(
                  onTap: () {
                    authProvider.setUser = StateHandler.initial();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ));
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                              text: "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
