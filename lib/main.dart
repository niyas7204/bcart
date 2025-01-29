import 'package:amazone_clone/admin/features/products/provider/add_product_provider.dart';
import 'package:amazone_clone/auth/presentation/pages/login_page.dart';
import 'package:amazone_clone/auth/provider/user_provider.dart';
import 'package:amazone_clone/core/constants/key.dart';
import 'package:amazone_clone/user/features/cart/provider/cart_provider.dart';
import 'package:amazone_clone/user/features/global/presentation/pages/user_landing_page.dart';
import 'package:amazone_clone/user/features/home/providers/home_page_product_provider.dart';
import 'package:amazone_clone/user/features/products/providers/user_products_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString(ConstantKeys.accesToken);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProductsProvider(),
        )
      ],
      child: MyApp(
        token: token,
      )));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: token != null ? LandingPage() : const LoginPage(),
    );
  }
}
