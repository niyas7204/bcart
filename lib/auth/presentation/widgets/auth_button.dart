import 'package:amazone_clone/auth/controller/provider/user_provider.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuhtButton extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onPressed;
  final GlobalKey<FormState> formKey;
  const AuhtButton(
      {super.key,
      required this.isLogin,
      required this.onPressed,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.primeryColor1),
      child: ElevatedButton(
          onPressed: authProvider.user.status != StateStatuse.loading
              ? onPressed
              : null,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Adjust the radius as needed
              ),
              fixedSize: Size(size.width - 20, 50),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent),
          child: authProvider.user.status == StateStatuse.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  "NEXT",
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )),
    );
  }
}
