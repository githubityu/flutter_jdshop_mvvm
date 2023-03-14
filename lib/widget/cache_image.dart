import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterjdshop/local/local_exports.dart';
import 'package:flutter/material.dart';


class CacheImage extends StatelessWidget {
  const CacheImage({
    Key? key,
    required this.path,
    this.fit = BoxFit.fill,
    this.errorWidget,
    this.placeholder,
  }) : super(key: key);
  final String? path;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? placeholder;

  Widget customNetworkImage(String? path, {BoxFit? fit = BoxFit.cover}) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: path??Constants.picUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholderFadeInDuration: const Duration(milliseconds: 500),
      placeholder: (context, url) => placeholder??Container(
        color: const Color(0xffeeeeee),
      ),
      cacheKey: path,
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            color: const Color(0xffeeeeee),
            child: Icon(
              Icons.error,
              color: Colors.grey[700],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return customNetworkImage(path, fit: fit);
  }
}
