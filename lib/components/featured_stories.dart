import 'package:flutter/material.dart';
import '../components/carousel.dart' as carousel;
import '../components/cards.dart' as card;

/* This widget adds the featured stories in the home page */

class HomeScreenChildren extends StatelessWidget {
  const HomeScreenChildren({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      controller: controller,
      children: childrenList(storyCardData),
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

List<Widget> carouselItems = [
  const carousel.CarouselComponent(),
  const Padding(
    padding: EdgeInsets.all(12.0),
    child: Divider(color: Color.fromARGB(255, 181, 181, 181),),
  ),
  const SizedBox(height: 4,),
  const Text(
    'FEATURED STORIES',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: 'LeagueSpartan',
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
  ),
  const SizedBox(height: 4,),
];

List<Widget> childrenList(cardData) {
  List<Widget> storyList= [];
  for (var data in storyCardData) {
    var {
      'userImage': userImage,
      'userName': userName,
      'storyHeadline': storyHeadline,
      'image': image,
      'date': date
    } = data;
    // print('userImage: $userImage | userName: $userName | headline: $storyHeadline');
    storyList.add(card.LargeGreyPictureCard(
      userImage: userImage,
      userName: userName,
      storyHeadline: storyHeadline,
      image: image,
      date: date,
    ));
    storyList.add(const SizedBox(height: 15,));
  }
  // storyList.add(
  //   const Padding(
  //     padding: EdgeInsets.all(12.0),
  //     child: Divider(color: Color.fromARGB(255, 181, 181, 181),),
  //   ),
  // );
  storyList.add(
    Center(
      child: IconButton(
        icon: const Icon(Icons.arrow_circle_up),
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

const List storyCardData = [
  {
    'userImage': 'assets/img/users/jn_user.jpg',
    'userName': 'Jason Navarro',
    'storyHeadline': 'Transparency Matters',
    'image': 'assets/img/stories/journal_story.jpg',
    'date': 'March 2, 2024',
  },
  {
    'userImage': 'assets/img/users/sa_user.jpg',
    'userName': 'Carlos Mendoza',
    'storyHeadline': 'Leading By Example',
    'image': 'assets/img/stories/fork_story.png',
    'date': 'March 15, 2024',
  },
  {
    'userImage': 'assets/img/users/sa_user.jpg',
    'userName': 'Sandro Aguilar',
    'storyHeadline': 'Innovative Thinking',
    'image': 'assets/img/stories/compass_story.jpg',
    'date': 'April 15, 2024',
  },
];