import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;

// Screen Arguments Extractor
class ScreenArguments {
  final String title;
  final String lettersImg;
  final Map policyTxt;
  ScreenArguments({required this.title, required this.lettersImg, required this.policyTxt});
}

// Gridclass
class MasonryGridTile extends StatelessWidget {
  final String image;
  final String title;
  final String route;
  final String lettersImg;
  final Map policyTxt;
  const MasonryGridTile({
    super.key,
    required this.image,
    required this.title,
    required this.route,
    required this.lettersImg,
    required this.policyTxt
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        route,
        arguments: ScreenArguments(
          title: title,
          lettersImg: lettersImg,
          policyTxt: policyTxt,
        ),
      ),
      child: Card(
        color: Get.isDarkMode ? theme.darkGreyClr : theme.whiteClr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              // child: ColoredBox(
                // color: Color(0xff534343),
                child: Image(
                  image: AssetImage(image),
                  // width: 186,
                ),
              // ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile( // MIGHT BE BEST TO USE AN EXPANDED WIDGET TO HOLD THE TEXT
                    // contentPadding: EdgeInsets.all(0),
                    title: Text(
                      title,
                      style: theme.TextThemes.headlineSmall(context)
                      // style: const TextStyle(
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 20,
                      //   color: Color.fromRGBO(74, 74, 74, 1)
                      // ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}