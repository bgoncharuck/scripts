import 'package:flutter/widgets.dart';

/// AssetImage name is reserved for [AssetImage](https://api.flutter.dev/flutter/painting/AssetImage-class.html)
/// Thus, the widget is named AssettImage, with two **tt**
class AssettImage extends StatefulWidget {
  /// Precaches given asset and just returns ```Image``` as it is
  const AssettImage(
    this.asset, {
    this.width,
    this.height,
    this.fit = BoxFit.fitWidth,
    super.key,
  });
  final String asset;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  State<AssettImage> createState() => _AssettImageState();
}

class _AssettImageState extends State<AssettImage> {
  late final Image cachedImage;

  @override
  void initState() {
    super.initState();
    cachedImage = Image.asset(
      gaplessPlayback: true,
      widget.asset,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await precacheImage(cachedImage.image, context);
  }

  @override
  Widget build(BuildContext context) => cachedImage;
}

Future<Image> cacheAsset({
  required String ass,
  required double width,
  required double height,
  required BoxFit fit,
  required BuildContext context,
}) async {
  final cachedImage = Image.asset(
    gaplessPlayback: true,
    ass,
    width: width,
    height: height,
    fit: fit,
  );
  await precacheImage(cachedImage.image, context);
  return cachedImage;
}
