import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';

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
    if (images != null && images!.isNotEmpty) {
      // Construct the full URL
      final String fullImageUrl = images!.startsWith('http')
          ? images!
          : "${Application.picturesURL}admin/Homepage.jpg";

      return CachedNetworkImage(
        imageUrl: fullImageUrl,
        fit: BoxFit.cover,
        height: height,
        width: double.maxFinite,
        placeholder: (context, url) {
          return AppPlaceholder(
            child: Container(
              height: height,
              color: Colors.white,
            ),
          );
        },
        errorWidget: (context, url, error) {
          return AppPlaceholder(
            child: Container(
              height: height,
              color: Colors.white,
              child: const Icon(Icons.error),
            ),
          );
        },
      );
    }

    // Fallback for when there is no image
    return Container(
      height: height,
      color: Theme.of(context).colorScheme.surface,
      child: AppPlaceholder(
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}