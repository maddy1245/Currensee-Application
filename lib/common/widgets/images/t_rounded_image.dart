import 'package:eproject_currensee/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TRoundImage extends StatelessWidget {
  const TRoundImage({
   super.key,
this.border,
this.padding,
this.onPressed,
this.width,
this.height,
this.applyImageRadius = true,
required this.imageUrl,
this.fit = BoxFit.contain,
this.backgroundColor = Colors.transparent,
this.isNetworkImage = false,
 this.borderradius = Tsizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderradius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderradius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderradius)
              : BorderRadius.zero,
          child: Image(
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider,
              fit: fit),
        ),
      ),
    );
  }
}
