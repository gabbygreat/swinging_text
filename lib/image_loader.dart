import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoader extends StatelessWidget {
  final String image;
  final String? captionText;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? boxFit;
  final BoxShape? boxShape;
  final Color? color;
  final BlendMode? blendMode;
  final void Function()? onTap;
  final bool box;
  final bool? cache;
  final bool? isResource;
  final bool? isSocial;
  const ImageLoader({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.boxFit,
    this.boxShape,
    this.radius,
    this.captionText,
    this.box = false,
    this.onTap,
    this.blendMode,
    this.color,
    this.isResource,
    this.cache,
    this.isSocial,
  });
  @override
  Widget build(BuildContext context) {
    var image_ = image.startsWith('https') ? image : 'https://$image';
    return ExtendedImage.network(
      image_,
      fit: BoxFit.fill,
      width: width,
      shape: boxShape,
      height: height,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.3),
              highlightColor: Colors.white.withOpacity(0.2),
              child: const Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            );
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              fit: boxFit,
              color: color,
              colorBlendMode: blendMode,
            );
          case LoadState.failed:
            return AspectRatio(
              aspectRatio: 1 / 1.2,
              child: Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                color: Colors.white70,
                child: GestureDetector(
                  child: const Center(
                    child: Icon(
                      Icons.replay_outlined,
                      size: 60,
                    ),
                  ),
                  onTap: () => state.reLoadImage(),
                ),
              ),
            );
        }
      },
    );
  }
}
