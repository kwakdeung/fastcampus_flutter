import 'package:e_commerce_app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/theme_data.dart';
import 'data/data_source/mock/display/display_mock_api.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/splash/splash_page.dart';

void main() async {
  final data = await DisplayMockApi().getMenusByMallType('market');
  print(data);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
