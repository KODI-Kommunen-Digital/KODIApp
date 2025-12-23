import 'package:flutter/material.dart';
// import 'package:heidi/src/presentation/main/home/widget/city_dropdown.dart';
import 'package:heidi/src/presentation/main/home/widget/home_swiper.dart';

class AppBarHomeSliver extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String? banners;
  final ValueSetter<String>? setLocationCallback;
  final List<String>? cityTitlesList;
  final String? hintText;
  final String? selectedOption;

  AppBarHomeSliver({
    required this.expandedHeight,
    required this.setLocationCallback,
    required this.cityTitlesList,
    this.banners,
    this.hintText,
    this.selectedOption,
  });

  static const double _minHeight = 120;

  @override
  double get minExtent => _minHeight;

  @override
  double get maxExtent => expandedHeight < _minHeight
      ? _minHeight
      : expandedHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        HomeSwipe(
          images: banners,
          height: maxExtent,
        ),
        Container(
          height: 25,
          color: Theme.of(context).colorScheme.surface,
        ),
        // CitiesDropDown(
        //   hintText: hintText,
        //   cityTitlesList: cityTitlesList,
        //   setLocationCallback: setLocationCallback,
        //   selectedOption: selectedOption,
        // ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}