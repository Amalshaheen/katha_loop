import 'package:flutter/material.dart';
import 'package:katha_loop/core/color_scheme.dart';

class StyledIcon extends StatelessWidget {
  const StyledIcon(this.iconData,{super.key});
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: ColorSchemeNew.primary,
    );
  }
}
