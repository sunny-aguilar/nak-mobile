import 'package:flutter/material.dart';
import 'package:nak_app/components/carousel.dart' as carousel;
import 'package:nak_app/components/cards.dart' as card;
import 'package:nak_app/db/home_db.dart' as home_db;

/* This widget adds the featured stories in the home page */
class HomeScreenChildren extends StatefulWidget {
  const HomeScreenChildren({super.key});
  @override
  State<HomeScreenChildren> createState() => _HomeScreenChildrenState();
}

class _HomeScreenChildrenState extends State<HomeScreenChildren> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: childrenList(home_db.storyCardData),
    );
  }
}

final ScrollController controller = ScrollController();
void scrollUp() {
  controller.animateTo(
    controller.position.minScrollExtent,
    duration: const Duration(seconds: 1),
    curve: Curves.fastOutSlowIn,
  );
}

// create final list of children
List<Widget> childrenList(cardData) {
  List<Widget> storyList= [];
  // add story components
  storyList.add(const carousel.CarouselComponent());
  storyList.add(const SizedBox(height: 4,));
  addStoryCards(home_db.storyCardData, storyList);
  // add scroll up button
  storyList.add(
    Center(
      child: IconButton(
        icon: const Icon(Icons.arrow_circle_up, size: 30,),
        onPressed: () {
          scrollUp();
        },
      ),
    ),
  );
  storyList.add(const SizedBox(height: 20,));
  return storyList;
}

/// add story cards
void addStoryCards(cardData, storyList) {
  storyList.add(const SizedBox(height: 4,));
  for (var data in home_db.storyCardData) {
    var {
      'userImage': userImage,
      'userName': userName,
      'storyHeadline': storyHeadline,
      'image': image,
      'date': date,
      'storyText': storyText,
    } = data;
    storyList.add(card.LargeGreyPictureCard(
      userImage: userImage,
      userName: userName,
      storyHeadline: storyHeadline,
      image: image,
      date: date,
      storyText: storyText,
    ));
    storyList.add(const SizedBox(height: 15,));
  }
}


/// FOR LATER DEVELOPMENT
// class GridCards extends StatelessWidget {
//   const GridCards({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 2,
//       mainAxisSpacing: 4,
//       crossAxisSpacing: 4,
//       physics: const NeverScrollableScrollPhysics(),  // to disable GridView's scrolling
//       shrinkWrap: true, // You won't see infinite size error
//       children: List.generate(4, (index) {
//         return HomeGridCards(index: index);
//       }),
//     );
//   }
// }

// class HomeGridCards extends StatelessWidget {
//   final int index;
//   const HomeGridCards({super.key, required this.index});
//   @override
//   Widget build(BuildContext context) {
//     return Card.filled(
//       color: Color.fromARGB(255, 251, 219, 255),
//       child: Center(
//         child: Text('Item: $index'),
//       ),
//     );
//   }
// }