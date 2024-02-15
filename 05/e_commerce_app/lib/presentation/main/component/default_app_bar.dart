import 'package:e_commerce_app/core/constant/app_icons.dart';
import 'package:e_commerce_app/presentation/main/cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar(this.bottomNav, {super.key});
  final BottomNav bottomNav;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      color: Theme.of(context).colorScheme.primary,
      child: AppBar(
        title: Text(
          bottomNav.toName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
    );
  }
}
