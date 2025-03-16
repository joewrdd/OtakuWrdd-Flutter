import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:OtakuWrdd/utils/shimmers/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = ConstantSizes.sm,
    this.radius = 100,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding, radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (ConstantColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Center(
          child:
              isNetworkImage
                  ? CachedNetworkImage(
                    imageUrl: image,
                    fit: fit,
                    color: overlayColor,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const TShimmerEffect(
                              width: 110,
                              height: 110,
                              radius: 100,
                            ),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  )
                  : Image(
                    fit: fit,
                    image:
                        isNetworkImage
                            ? NetworkImage(image)
                            : AssetImage(image) as ImageProvider,
                    color: overlayColor,
                  ),
        ),
      ),
    );
  }
}
