import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage(
      {Key? key, this.url, this.boxFit, this.height, this.width})
      : super(key: key);
  final String? url;
  final BoxFit? boxFit;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return (Uri.parse(url ?? "").isAbsolute)
        ? CachedNetworkImage(
            imageUrl: url ?? "",
            width: width,
            height: height,
            fit: (boxFit) ?? BoxFit.contain,
            placeholder: (_, url) =>
                Center(child: Utils.putShimmer(height: height, width: width)),
            errorWidget: (_, url, error) => const Icon(Icons.error),
          )
        : const Icon(Icons.error);
  }
}
