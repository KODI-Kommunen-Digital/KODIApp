import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/painting.dart';
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

  /// Print actual cache folder
  Future<String> getCachePath() async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/$key';
    print('📂 Cache directory: $path');
    return path;
  }

  /// Forcefully clear everything (disk + memory)
  Future<void> forceClearCache() async {
    try {
      final path = await getCachePath();
      final cacheDir = Directory(path);

      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
        print('✅ Cache directory deleted!');
      } else {
        print('⚠️ Cache directory not found');
      }

      // Clear Flutter image cache
      imageCache.clear();
      imageCache.clearLiveImages();
    } catch (e) {
      print('❌ Error clearing cache: $e');
    }
  }

  /// Clears all cache (logical + disk)
  Future<void> clearCacheCompletely() async {
    await emptyCache(); // FlutterCacheManager cleanup
    await forceClearCache(); // Ensure files are gone
  }

  /// Check size and auto clear if exceeds limit
  Future<void> clearIfExceedsLimit({int limitMB = 100}) async {
    try {
      final path = await getCachePath();
      final dir = Directory(path);

      if (!await dir.exists()) return;

      int totalBytes = 0;
      await for (var file in dir.list(recursive: true)) {
        if (file is File) totalBytes += await file.length();
      }

      final sizeMB = totalBytes / (1024 * 1024);
      print('📦 Cache size: ${sizeMB.toStringAsFixed(2)} MB');

      if (sizeMB > limitMB) {
        print('⚠️ Cache exceeds $limitMB MB — clearing...');
        await clearCacheCompletely();
      }
    } catch (e) {
      print('❌ Error checking cache size: $e');
    }
  }
}
