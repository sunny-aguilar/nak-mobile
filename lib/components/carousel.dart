import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselComponent extends StatefulWidget {
  const CarouselComponent({super.key});
  @override
  State<CarouselComponent> createState() => _CarouselComponentState();
}

class _CarouselComponentState extends State<CarouselComponent> {
  late PageController _pageController;
  int activePage = 0;
  List<String> images = [
    'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg',
    'https://images.pexels.com/photos/1714208/pexels-photo-1714208.jpeg',
    'https://images.pexels.com/photos/1714205/pexels-photo-1714205.jpeg',
    'https://images.pexels.com/photos/2115257/pexels-photo-2115257.jpeg',
  ];
  List<String> imagesAssets = [
    'assets/img/carousel/nakfest_logo.webp',
    'assets/img/carousel/nakfest_logo.webp',
    'assets/img/carousel/nakfest_logo.webp',
    'assets/img/carousel/nakfest_logo.webp',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColoredBox(
          color: const Color.fromARGB(255, 239, 239, 239),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                // stops: [0.1, 0.4, 0.6, 0.9],  // b,r,b
                colors: [
                  // Color.fromARGB(255, 26, 26, 26),
                  // Colors.red,
                  // Color.fromARGB(255, 26, 26, 26),
                  // Color(0xff67a3b2),
                  Color.fromARGB(255, 196, 17, 47),
                  Color(0xff242020),
                  // Color(0xfff6cf35),
                ],
            ),
              // image: DecorationImage(
              //   image: AssetImage(
              //     'assets/img/carousel/nak_letters.webp',
              //   ),
              //   fit: BoxFit.fill,
              // ),
            ),
            child: SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: 4,
                pageSnapping: true,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  bool active = pagePosition == activePage;
                  return slider(imagesAssets, pagePosition, active);
                },
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(imagesAssets.length, activePage),
        ),
      ],
    );
  }
}


AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 10 : 20;
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    child: Image.asset(
      images[pagePosition],
      fit: BoxFit.cover,
    ),
    // decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: NetworkImage(images[pagePosition]),
    //       fit: BoxFit.cover,
    //     ),
    //     // image: DecorationImage(
    //     //   image: NetworkImage(images[pagePosition]),
    //     //   fit: BoxFit.cover,
    //     // ),
    // ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.black : Colors.black26,
        shape: BoxShape.circle,
      ),
    );
  });
}
