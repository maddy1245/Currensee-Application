import 'package:eproject_currensee/utils/constants/colors.dart';
import 'package:flutter/rendering.dart';

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: TColors.darkgrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2)
  );
  static final horizontalProductShadow = BoxShadow(
    color: TColors.darkgrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2)
  );
}
