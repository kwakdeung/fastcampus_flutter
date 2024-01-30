import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market/firebase_options.dart';
import 'package:market/home/cart_screen.dart';
import 'package:market/home/home_screen.dart';
import 'package:market/home/product_detail_screen.dart';
import 'package:market/login/login_screen.dart';
import 'package:market/login/sign_up_screen.dart';
import 'package:market/model/product.dart';

List<CameraDescription> cameras = [];
UserCredential? userCredential;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  cameras = await availableCameras();

  if (kDebugMode) {
    try {
      await FirebaseAuth.instance.useAuthEmulator(
          "localhost", 9099); // 구글 로그인 사용하려면 잠시 Emulator 비활성화 해야 함.
      FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
      FirebaseStorage.instance.useStorageEmulator("localhost", 9199);
    } catch (e) {
      print(e);
    }
  }
  runApp(MarketApp());
}

class MarketApp extends StatelessWidget {
  MarketApp({super.key});
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
            builder: (context, state) {
              return ProductDetailScreen(product: state.extra as Product);
            },
          ),
          GoRoute(
            path: "product/add",
            builder: (context, state) {
              return ProductDetailScreen(product: state.extra as Product);
            },
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
