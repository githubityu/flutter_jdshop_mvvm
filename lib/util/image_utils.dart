import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/// 图片工具类
class ImageUtils {
  ///将base64流转化为图片
  static MemoryImage base64ToImage(String base64String) {
    return MemoryImage(
      base64Decode(base64String),
    );
  }

  static Future<ui.Image> load(String asset,{int width = 5,int height = 3}) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  ///将base64流转化为Uint8List对象
  static Uint8List base64ToUnit8list(String base64String) {
    return base64Decode(base64String);
  }

  ///将图片file转化为base64
  static String fileToBase64(File imgFile) {
    return base64Encode(imgFile.readAsBytesSync());
  }

  ///将网络链接图片转化为base64
  // static Future networkImageToBase64(String url) async {
  //   http.Response response = await http.get(url);
  //   return base64.encode(response.bodyBytes);
  // }

  ///将asset图片转化为base64
  Future assetImageToBase64(String path) async {
    ByteData bytes = await rootBundle.load(path);
    return base64.encode(Uint8List.view(bytes.buffer));
  }

  static ImageProvider getImageProvider(String? picUrl, {Image? im,int? maxWidth,int? maxHeight}) {
    // if(picUrl.isNullOrEmpty) return Assets.images.icLauncher.image().image;
    return CachedNetworkImageProvider(picUrl!,maxHeight: maxHeight,maxWidth: maxWidth);
  }

  static Image getWidgetByFile(String file,
      {BoxFit? fit, double? width, double? height}) {
    return Image.file(
      File(file),
      fit: fit,
      width: width,
      height: height,
    );
  }

  static Image getWidgetByUint8List(Uint8List file,
      {BoxFit? fit, double? width, double? height}) {
    return Image.memory(
      file,
      fit: fit,
      width: width,
      height: height,
    );
  }


  static Image getImageByUrl(String url,{BoxFit? fit}){
     return Image(image: CachedNetworkImageProvider(url),fit: fit??BoxFit.fill,);
  }



}
