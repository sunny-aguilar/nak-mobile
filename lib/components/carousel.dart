import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselComponent extends StatefulWidget {
  const CarouselComponent({super.key});
  @override
  State<CarouselComponent> createState() => _CarouselComponentState();
}

class _CarouselComponentState extends State<CarouselComponent> {
  late PageController _pageController;
  int activePage = 0;

  List<String> imagesArr = [
    'assets/img/carousel/nakfest_carousel.webp',
    'assets/img/carousel/nldc_carousel.PNG',
    'assets/img/carousel/email_carousel.webp',
    'assets/img/carousel/store_carousel.webp',
  ];
  List<String> urlArr = [
    'https://naknet.org/programming/nakfest2025/',
    'https://naknet.org/store/#!/NLDC-2023/p/376065284/category=72126034',
    'https://naknet.org/newnakincaddress/',
    'https://shopnualphakappa.com/',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.05, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            itemCount: imagesArr.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, pagePosition) {
              bool active = pagePosition == activePage;
              return slider(context, imagesArr, pagePosition, active, urlArr);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: imagesArr.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  dotColor: Color.fromARGB(255, 230, 230, 230),
                  activeDotColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


AnimatedContainer slider(context, imagesAssets, pagePosition, active, urlArr) {
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
        launchUrlStart(url: urlArr[pagePosition]);
      },
      child: Card.filled(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0)
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          imagesAssets[pagePosition],
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}