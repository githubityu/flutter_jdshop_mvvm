import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheManager {
  const CacheManager._();

  static const int kb = 1024;
  static const int mb = 1024 * kb;
  static const int gb = 1024 * mb;

  static Future<Directory> cacheDir() => getTemporaryDirectory();

  static Future<void> clear() async {
    final Directory dir = await cacheDir();
    await Future.wait(
      <Future<void>>[
        for (final FileSystemEntity f in dir.listSync())
          f.delete(recursive: true),
      ],
    );
  }

  static Future<int> cacheSize() async {
    final Directory dir = await cacheDir();
    final List<FileSystemEntity> listSync = dir.listSync(recursive: true);
    int size = 0;
    for (final FileSystemEntity file in listSync) {
      size += file.statSync().size;
    }
    return size;
  }

  static Future<String> formatCacheSize() async {
    final int size = await cacheSize();
    if (size >= gb) {
      return '${(size / gb).toStringAsFixed(2)} GB';
    }
    if (size >= mb) {
      return '${(size / mb).toStringAsFixed(2)} MB';
    }
    if (size >= kb) {
      return '${(size / kb).toStringAsFixed(2)} KB';
    }
    return '$size B';
  }
}