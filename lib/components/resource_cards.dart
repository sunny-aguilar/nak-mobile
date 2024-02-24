import 'package:flutter/material.dart';

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
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(8.0),
        //   // color: const Color(0xff534343), // adds background color to entire card
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)
              ),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromRGBO(74, 74, 74, 1)
                      ),
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