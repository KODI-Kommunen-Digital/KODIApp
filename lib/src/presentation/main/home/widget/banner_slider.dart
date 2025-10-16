import 'package:flutter/material.dart';
import '../../../../utils/common.dart';
import '../../../../utils/translate.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final String imageUrl = "assets/images/home/banner.jpg";
  final String title =
      "Suchst du nach einem Job? Oder suchst du Mitarbeiter:innen? Dann registriere dich jetzt und nutze unser Job-Matching!";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translate.of(context).translate('apply_for_our_region'),
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    onTap: () {
                      Utils().showAlertMessage(
                        'this_feature_will_be_available_soon',
                        context,
                      );
                    },
                    child: RepaintBoundary(
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        cacheWidth: 400,
                        cacheHeight: 200,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 10),
          // const SizedBox(height: 8),
        ],
      ),
    );
  }
}
