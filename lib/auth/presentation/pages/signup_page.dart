import 'package:amazone_clone/auth/provider/user_provider.dart';
import 'package:amazone_clone/core/contants/colors.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/widgets/sized_boxes.dart';
import 'package:amazone_clone/auth/presentation/widgets/auth_button.dart';
import 'package:amazone_clone/auth/presentation/widgets/auth_textfield.dart';
import 'package:amazone_clone/user/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider authProvider = Provider.of<UserProvider>(
      context,
    );
    authProvider.addListener(
      () {
        if (authProvider.user.status == StateStatuse.success) {
          emailController.clear();
          nameController.clear();
          passwordController.clear();
          authProvider.setUser = StateHandler.initial();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        }
      },
    );
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        authProvider.setUser = StateHandler.initial();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create your account",
                        style: TextStyle(
                            color: AppTheme.primeryColor5,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      WhiteSpaces.height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.primeryColor1,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      AuthField(
                        controller: nameController,
                        hintText: "Name",
                        formKey: formKey,
                      ),
                      WhiteSpaces.height10,
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
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Provider.of<UserProvider>(context, listen: false)
                                .userLogin(
                                    email: emailController.text.trim(),
                                    name: nameController.text.trim(),
                                    password: passwordController.text.trim());
                          }
                        },
                        isLogin: false,
                      ),
                      WhiteSpaces.height20,
                      GestureDetector(
                        onTap: () {
                          authProvider.setUser = StateHandler.initial();
                          Navigator.pop(context);
                        },
                        child: RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                  color: AppTheme.primeryColor5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: "Sign In",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: AppTheme.primeryColor1,
                                            fontWeight: FontWeight.bold))
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
