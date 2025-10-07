import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class CustomCacheManager extends CacheManager {
  static const key = "customCache";
  static final CustomCacheManager _instance = CustomCacheManager._();

  factory CustomCacheManager() => _instance;

  CustomCacheManager._()
      : super(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 25,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );

  /// Clears all cached files
  Future<void> clearCustomCache() async {
    await emptyCache();
    print('✅ Custom cache cleared!');
  }

  /// Checks cache size and clears if it exceeds 100 MB
  Future<void> clearIfExceedsLimit({int limitInMB = 100}) async {
    final cacheDir = await getTemporaryDirectory();
    final cacheFolder = Directory('${cacheDir.path}/$key');

    if (!await cacheFolder.exists()) return;

    int totalBytes = 0;
    await for (var file in cacheFolder.list(recursive: true, followLinks: false)) {
      if (file is File) {
        totalBytes += await file.length();
      }
    }

    double totalMB = totalBytes / (1024 * 1024);

    print('📦 Current cache size: ${totalMB.toStringAsFixed(2)} MB');

    if (totalMB > limitInMB) {
      print('⚠️ Cache size exceeded $limitInMB MB — clearing...');
      await clearCustomCache();
    }
  }
}
