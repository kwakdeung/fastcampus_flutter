import 'package:flutter/material.dart';
import 'package:market/home/home_screen.dart';
import 'package:market/home/product_add_screen.dart';
import 'package:market/login/login_screen.dart';
import 'package:market/login/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '마트',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
