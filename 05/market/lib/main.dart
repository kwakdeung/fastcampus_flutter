import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market/home/cart_screen.dart';
import 'package:market/home/home_screen.dart';
import 'package:market/home/product_add_screen.dart';
import 'package:market/home/product_detail_screen.dart';
import 'package:market/login/login_screen.dart';
import 'package:market/login/sign_up_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final router = GoRouter(
    initialLocation: "/login",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            path: "cart/:uid",
            builder: (context, state) => CartScreen(
              uid: state.pathParameters["uid"] ?? "",
            ),
          ),
          GoRoute(
            path: "product",
            builder: (context, state) => ProductDetailScreen(),
          ),
          GoRoute(
            path: "product/add",
            builder: (context, state) => ProductDetailScreen(),
          ),
        ],
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: "/sign_up",
        builder: (context, state) => SignUpScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '마트',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
