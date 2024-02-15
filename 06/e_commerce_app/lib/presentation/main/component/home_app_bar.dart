import 'package:e_commerce_app/core/constant/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      color: Theme.of(context).colorScheme.primary,
      child: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(AppIcons.mainLogo),
        ),
        title: Text(
          'tabBar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(
              AppIcons.location,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.background,
                BlendMode.srcIn,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(
              AppIcons.cart,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.background,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leadingWidth: 86,
      ),
    );
  }
}
