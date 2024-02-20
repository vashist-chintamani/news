import 'package:mobile_app_platform_widgets/common_exports.dart';

class TYRIOSCacheImage extends StatelessWidget {
  final BoxFit? fit;
  final double? width;
  final double? height;
  final String imageUrl;
  final Object? animationId;

  const TYRIOSCacheImage({
    super.key,
    this.width,
    this.height,
    this.animationId,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (animationId == null) {
      if (imageUrl.isNotEmpty) {
        return CachedNetworkImage(
          fit: fit,
          width: width,
          height: height,
          imageUrl: imageUrl,
          errorWidget: (_, __, ___) => const SizedBox.shrink(),
        );
      } else {
        return CachedNetworkImage(
          fit: fit,
          width: width,
          height: height,
          imageUrl: imageUrl,
          placeholder: (_, __) => const SizedBox.shrink(),
          errorWidget: (_, __, ___) => const SizedBox.shrink(),
        );
      }
    }
    if (imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        fit: fit,
        width: width,
        height: height,
        imageUrl: imageUrl,
        errorWidget: (_, __, ___) => const SizedBox.shrink(),
      );
    } else {
      return CachedNetworkImage(
        fit: fit,
        width: width,
        height: height,
        imageUrl: imageUrl,
        placeholder: (_, __) => const SizedBox.shrink(),
        errorWidget: (_, __, ___) => const SizedBox.shrink(),
      );
    }
  }
}
