import 'package:flutter/material.dart';
import '../../../../utils/common.dart';
import '../../../../utils/translate.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> imageUrls = [
    "assets/images/home/banner.jpg"
  ];
  final List<String> titleList = [
    "Suchst du nach einem Job? Oder suchst du Mitarbeiter:innen? Dann registriere dich jetzt und nutze unser Job-Matching! Finde deinen Traumjob oder die passenden Mitarbeitenden in der Region!",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                Translate.of(context).translate('apply_for_our_region'),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: imageUrls.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    onTap: (){
                      Utils().showAlertMessage('this_feature_will_be_available_soon', context);
                    },
                    child: Stack(
                      children: [
                        Image.asset(imageUrls[index],
                          fit: BoxFit.cover,
                          cacheWidth: 400,
                          cacheHeight: 200,
                          height: double.infinity,
                          width: double.infinity,),
                        // CachedNetworkImage(
                        //   fit: BoxFit.cover,
                        //   width: double.infinity,
                        //   imageUrl:imageUrls[index],
                        // ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.black38,
                              child: Center(child: Text(
                                titleList[index],
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ))),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Dots Indicator
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(imageUrls.length, (index) {
          //     return Container(
          //       margin: const EdgeInsets.symmetric(horizontal: 4),
          //       width: _currentPage == index ? 12 : 8,
          //       height: _currentPage == index ? 12 : 8,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: _currentPage == index
          //             ? Colors.blueAccent
          //             : Colors.grey.shade400,
          //       ),
          //     );
          //   }),
          // ),
        ],
      ),
    );
  }
}
