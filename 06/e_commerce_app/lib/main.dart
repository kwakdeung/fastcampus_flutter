import 'package:e_commerce_app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/theme_data.dart';
import 'data/data_source/mock/display/display_mock_api.dart';
import 'data/repository_impl/display.repository_impl.dart';
import 'domain/usecase/display/display.usecase.dart';
import 'domain/usecase/display/menu/get_menus.usecase.dart';
import 'presentation/main/cubit/mall_type_cubit.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'service_locator.dart';

void main() async {
  setLocator();
  // final menus = await DisplayUsecase(DisplayRepositoryImpl(DisplayMockApi()))
  //     .excute(usecase: GetMenusUsecase(mallType: MallType.market));
  final menus = await locator<DisplayUsecase>()
      .excute(usecase: GetMenusUsecase(mallType: MallType.market));
  print(menus);
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
