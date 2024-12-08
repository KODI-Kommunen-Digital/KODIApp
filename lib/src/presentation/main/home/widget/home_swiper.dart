import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';

class HomeSwipe extends StatelessWidget {
  final double height;
  final String? images;

  const HomeSwipe({
    super.key,
    this.images,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    if (images != null) {
      return Swiper(
          itemBuilder: (BuildContext context, int index) {
            // todo - Revert to previous state once we push a new image with a resolution of 2000 x 763 to home page URL
            // These changes are made to match the home page header with Mitwitz app
            return CachedNetworkImage(
              imageUrl: "https://example.com/does-not-exist-1234.jpg",
              cacheManager: memoryCacheManager,
              placeholder: (context, url) {
                return Image.asset(
                  'assets/images/home_test.jpg', // Local asset as placeholder
                  fit: BoxFit.fitWidth,
                );
              },
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                 return Image.asset(
                  'assets/images/home_test.jpg', // Local asset as placeholder
                  fit: BoxFit.fitWidth,
                );
              },
            );
          },
          autoplayDelay: 3000,
          autoplayDisableOnInteraction: false,
          autoplay: false,
          itemCount: images!.length,
          physics: const NeverScrollableScrollPhysics());
    }

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: AppPlaceholder(
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          color: Colors.white,
        ),
      ),
    );
  }
}
