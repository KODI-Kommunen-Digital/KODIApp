import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'dart:io';
import 'package:heidi/src/utils/configs/image.dart';

import 'package:heidi/src/utils/configs/application.dart';

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logo = isDarkMode ? Images.logo_dark : Images.logo_light;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: expandedHeight - shrinkOffset,
          child: Container(
            color: backgroundColor,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: Image.asset(logo),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 300),
                  child: SizedBox(
                    width: 26,
                    height: 26,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              ],
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
