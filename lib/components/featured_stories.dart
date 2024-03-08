import 'package:flutter/material.dart';
import '../components/carousel.dart' as carousel;
import '../components/cards.dart' as card;
import '../db/home_db.dart' as home_db;

/* This widget adds the featured stories in the home page */
class HomeScreenChildren extends StatelessWidget {
  const HomeScreenChildren({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
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

// list holding carousel children
List<Widget> carouselItems = [
  const carousel.CarouselComponent(),
  const SizedBox(height: 4,),
  const SizedBox(height: 4,),
  // const GridCards(),   // FOR LATER DEVELOPMENT
];

// create final list of children
List<Widget> childrenList(cardData) {
  List<Widget> storyList= [];
  for (var data in home_db.storyCardData) {
    var {
      'userImage': userImage,
      'userName': userName,
      'storyHeadline': storyHeadline,
      'image': image,
      'date': date,
      'storyText': storyText,
    } = data;
    // print('userImage: $userImage | userName: $userName | headline: $storyHeadline');
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
  // storyList.add(
  //   const Padding(
  //     padding: EdgeInsets.all(12.0),
  //     child: Divider(color: Color.fromARGB(255, 181, 181, 181),),
  //   ),
  // );
  storyList.add(const card.NotificationCard());
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
  storyList.add(const SizedBox(height: 35,));
  List<Widget> allItems = carouselItems + storyList;
  return allItems;
}

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