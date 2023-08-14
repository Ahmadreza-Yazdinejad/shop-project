import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/colors.dart';

import '../../data/model/banner.dart';
import 'catched_image.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerCampain> bannerList;
  BannerSlider({super.key, required this.bannerList});

  final controller = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.backgroundScreenColor,
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SizedBox(
              height: 177,
              child: PageView.builder(
                controller: controller,
                itemCount: bannerList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: CatchImage(
                      image: bannerList[index].thumbnail,
                      radius: 15,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 10,
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 4,
                  dotHeight: 6,
                  dotWidth: 6,
                  dotColor: Colors.white,
                  activeDotColor: CustomColor.blueIndicator,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddBuyBacket extends StatelessWidget {
  const AddBuyBacket({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
