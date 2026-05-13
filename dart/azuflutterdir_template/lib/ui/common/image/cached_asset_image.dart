import 'dart:io';

import 'package:flutter/widgets.dart';

class CachedAssetImage extends StatefulWidget {
  /// Precaches given asset and just returns ```Image``` as it is
  const CachedAssetImage(
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
  State<CachedAssetImage> createState() => _CachedAssetImageState();
}

class _CachedAssetImageState extends State<CachedAssetImage> {
  late final Image cachedImage;

  @override
  void initState() {
    super.initState();

    /// if download_groups installed
    // final path = assetsDownloader.getAssetPath('/${widget.asset}')
    //   ?..replaceAll('//', '/');
    final path = '/${widget.asset}'..replaceAll('//', '/');
    //
    // if (path == null) {
    //   cachedImage = Image.asset(
    //     'assets/images/no_image.png',
    //     width: widget.width,
    //     height: widget.height,
    //     fit: widget.fit,
    //   );
    // } else {
    cachedImage = Image.file(
      File(path),
      gaplessPlayback: true,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
    );
    // }
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await precacheImage(cachedImage.image, context);
  }

  @override
  Widget build(BuildContext context) => cachedImage;
}

Future<Image> cacheImage({
  required String ass,
  required double width,
  required double height,
  required BoxFit fit,
  required BuildContext context,
}) async {
  // final path = assetsDownloader.getAssetPath('/$ass')?..replaceAll('//', '/');
  final path = '/$ass'..replaceAll('//', '/');
  final cachedImage = Image.file(
    File(path),
    gaplessPlayback: true,
    width: width,
    height: height,
    fit: fit,
  );
  await precacheImage(cachedImage.image, context);
  return cachedImage;
}
