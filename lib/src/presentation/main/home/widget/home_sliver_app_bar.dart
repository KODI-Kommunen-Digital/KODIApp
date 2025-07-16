import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'dart:io';

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
          height: expandedHeight - shrinkOffset,
          child: CachedNetworkImage(
            imageUrl: "http://116.203.13.95:3000/static/media/City.3eb12d44ec0d128551c9.png",
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
          bottom: 10,
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
        if (Platform.isAndroid)
          Positioned(
            top: expandedHeight - shrinkOffset + 20,
            left: 0,
            right: 0,
            child: Container(
              height: 20,
              color: Colors.transparent,
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
