import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../commons/themedata.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

int _currentIndex = 0;
List images = [
  "assets/img/banner.jpg",
  "assets/img/baaner1.jpg",
  "assets/img/banner-2.jpg"
];

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
              width: double.maxFinite,
              height: 115,
              decoration: BoxDecoration(
                  color: Color(0xffF2F3F2),
                  borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.center,
              child: CarouselSlider(
                items: images.map((items) {
                  return Image.asset(
                    items,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    height: 115,
                  );
                }).toList(),
                carouselController: CarouselController(),
                options: CarouselOptions(
                    height: 115,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) =>
                        setState(() => _currentIndex = index)),
              )),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: images.asMap().entries.map((entry) {
                return Container(
                  width: 7,
                  height: 7,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == entry.key
                          ? Tcolor.primary
                          : Colors.grey.withOpacity(0.7)),
                );
              }).toList()),
        )
      ],
    );
  }
}
