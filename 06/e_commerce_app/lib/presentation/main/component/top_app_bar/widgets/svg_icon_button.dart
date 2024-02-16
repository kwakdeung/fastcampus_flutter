import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/app_icons.dart';

class SvgIconButton extends StatelessWidget {
  const SvgIconButton(
      {super.key, this.padding = 4.0, required this.icon, required this.color});

  final double padding;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
