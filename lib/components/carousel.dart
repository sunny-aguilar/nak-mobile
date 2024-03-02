import 'package:flutter/material.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
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
  List<String> route = [
    '',
    '',
    '',
    '',
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
            decoration: BoxDecoration(
              color: randomColor(),
            //   gradient: LinearGradient(
            //     begin: Alignment.bottomLeft,
            //     end: Alignment.topRight,
            //     // stops: [0.1, 0.4, 0.6, 0.9],  // b,r,b
            //     colors: [
            //       // Color.fromARGB(255, 26, 26, 26),
            //       // Colors.red,
            //       // Color.fromARGB(255, 26, 26, 26),
            //       // Color(0xff67a3b2),
            //       Color.fromARGB(255, 255, 255, 255),
            //       Color.fromARGB(255, 0, 0, 0),
            //       // Color(0xfff6cf35),
            //     ],
            // ),
            // ------ Image BG ---------------------------
              image: const DecorationImage(
                image: AssetImage(
                  'assets/img/nak_letters_bw.png',
                ),
                fit: BoxFit.contain,
              ),
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
                  return slider(context, imagesAssets, pagePosition, active);
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


AnimatedContainer slider(context, images, pagePosition, active) {
  double margin = active ? 10 : 20;
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    child: InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/chapters');
        Future<void> launchUrlStart({required String url}) async {
          if (!await launchUrl(Uri.parse(url))) {
            throw 'Could not launch $url';
          }
        }
        launchUrlStart(url: 'https://naknet.org/store/#!/NAKFEST-2024-Fresno/c/164050252');
      },
      child: Card.filled(
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          images[pagePosition],
          fit: BoxFit.cover,
        ),
      ),
    ),
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
        shape: BoxShape.rectangle,
      ),
    );
  });
}

Color randomColor() {
    const List<Color> bgColors = [
      Color(0xfffa5c58),  // light pink
      Color(0xff25bcc0),  // agua
      Color(0xffe17748),  // clay
      Color(0xffc6b782),  // official bronze
      Color(0xffbb8b65),  // mud
      Color(0xff242020),  // black
      Color(0xfff1f1f1),  // white
      Color(0xff67a3b1),  // sky
      Color(0xffA0C409),  // lime green
      Color(0xffc3102f),  // official red
      Color(0xfffef18e),  // light yellow
  ];
  Random random = Random();
  int randomNumber = random.nextInt(bgColors.length);
  return bgColors[randomNumber];
}