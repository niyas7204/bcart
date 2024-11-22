import 'package:amazone_clone/admin/features/home/admin_landing_page.dart';
import 'package:amazone_clone/admin/features/products/presentation/pages/add_product.dart';
import 'package:amazone_clone/admin/features/products/provider/add_prducti_provider.dart';
import 'package:amazone_clone/auth/presentation/pages/login_page.dart';
import 'package:amazone_clone/auth/provider/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AddPrductiProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
