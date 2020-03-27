import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterjdshop/utils/utils.dart';
import 'package:flutterjdshop/widget/load_image.dart';


class ImageUtils {

  static ImageProvider getAssetImage(String name, {String format: 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static ImageProvider getImageProvider(String imageUrl,
      {String holderImg: 'none'}) {
    if (getSafeData(imageUrl).isNotEmpty) {
      return AssetImage(getImgPath(holderImg));
    }
    return CachedNetworkImageProvider(
        imageUrl, errorListener: () => print("图片加载失败！"));
  }
}

