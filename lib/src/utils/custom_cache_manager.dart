import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager extends CacheManager {
  static const key = "customCache";
  static CustomCacheManager _instance = CustomCacheManager._();

  factory CustomCacheManager() => _instance;

  CustomCacheManager._()
      : super(Config(
    key,
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 25, // keep only 100 images cached
    repo: JsonCacheInfoRepository(databaseName: key),
    fileService: HttpFileService(),
  ));
}