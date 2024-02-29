import 'package:flutter/material.dart';
import 'package:hypermarket_addproduct/core/login_screen.dart';
import 'package:hypermarket_addproduct/presentation/product_screen/controller/product_controller.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
