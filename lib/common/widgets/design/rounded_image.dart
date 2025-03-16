import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomRoundedImage extends StatelessWidget {
  const CustomRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.onTap,
    this.borderRadius = ConstantSizes.sm,
    this.child,
    this.isSvg = false,
    this.isIcon = false,
    this.icon,
    this.iconSize = 20,
    this.iconColor = Colors.white,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double borderRadius;
  final Widget? child;
  final bool isSvg;
  final bool isIcon;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              border: border,
              color: backgroundColor ?? Colors.grey[800],
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: ClipRRect(
              borderRadius:
                  applyImageRadius
                      ? BorderRadius.circular(borderRadius)
                      : BorderRadius.zero,
              child:
                  isIcon
                      ? Icon(icon, size: iconSize, color: iconColor)
                      : isSvg
                      ? SvgPicture.asset(imageUrl, fit: fit ?? BoxFit.cover)
                      : isNetworkImage
                      ? Image(
                        image: NetworkImage(imageUrl),
                        fit: fit,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[850],
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.grey[600],
                                size: width != null ? width! * 0.3 : 30,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[850]!.withOpacity(0.5),
                            child: Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                      )
                      : Image(
                        image: AssetImage(imageUrl) as ImageProvider,
                        fit: fit,
                      ),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
