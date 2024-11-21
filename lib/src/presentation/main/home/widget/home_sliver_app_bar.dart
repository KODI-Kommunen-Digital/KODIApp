import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';

class AppBarHomeSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Function onSearch;

  AppBarHomeSliver({
    required this.expandedHeight,
    required this.onSearch,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CachedNetworkImage(
            imageUrl: "${Application.picturesURL}admin/Homepage.png",
            fit: BoxFit.cover,
            placeholder: (context, url) => AppPlaceholder(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            errorWidget: (context, url, error) => AppPlaceholder(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 16,
          child: SafeArea(
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => onSearch(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
