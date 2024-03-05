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

// list holding carousel children
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
      fontFamily: 'College',
      fontSize: 34,
      fontWeight: FontWeight.bold,
    ),
  ),
  const SizedBox(height: 4,),
];

// create final list of children
List<Widget> childrenList(cardData) {
  List<Widget> storyList= [];
  for (var data in storyCardData) {
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

const List storyCardData = [
  {
    'userImage': 'assets/img/users/jn_user.jpg',
    'userName': 'Jason Navarro',
    'storyHeadline': 'Transparency Matters',
    'image': 'assets/img/stories/journal_story.jpg',
    'date': 'March 2, 2024',
    'storyText': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque. Scelerisque felis imperdiet proin fermentum leo. Praesent semper feugiat nibh sed pulvinar proin gravida hendrerit. Aliquam faucibus purus in massa tempor nec feugiat nisl pretium. Mauris nunc congue nisi vitae suscipit tellus mauris a. Urna nunc id cursus metus aliquam eleifend mi. Praesent tristique magna sit amet. Sed elementum tempus egestas sed sed risus pretium quam. Nulla facilisi cras fermentum odio eu feugiat pretium nibh ipsum.',
  },
  {
    'userImage': 'assets/img/users/sa_user.webp',
    'userName': 'Carlos Mendoza',
    'storyHeadline': 'Leading By Example',
    'image': 'assets/img/stories/fork_story.png',
    'date': 'March 15, 2024',
    'storyText': 'Dictum fusce ut placerat orci nulla pellentesque. Tincidunt praesent semper feugiat nibh sed pulvinar proin gravida. Ut tellus elementum sagittis vitae et leo duis. Tincidunt eget nullam non nisi est sit amet. Feugiat vivamus at augue eget arcu dictum varius. Diam donec adipiscing tristique risus nec feugiat in fermentum. Nulla pharetra diam sit amet. Sed felis eget velit aliquet sagittis id consectetur. Eu lobortis elementum nibh tellus molestie. Cras tincidunt lobortis feugiat vivamus at. Maecenas sed enim ut sem viverra aliquet eget sit. Eget est lorem ipsum dolor sit amet consectetur. Leo integer malesuada nunc vel risus commodo viverra maecenas accumsan. Tortor at risus viverra adipiscing at in tellus integer feugiat. Non arcu risus quis varius quam quisque id. Morbi tincidunt augue interdum velit euismod in pellentesque massa placerat.',
  },
  {
    'userImage': 'assets/img/users/sa_user.webp',
    'userName': 'Sandro Aguilar',
    'storyHeadline': 'Innovative Thinking',
    'image': 'assets/img/stories/compass_story.jpg',
    'date': 'April 15, 2024',
    'storyText': 'Purus viverra accumsan in nisl nisi scelerisque eu ultrices vitae. Sed enim ut sem viverra aliquet eget sit amet tellus. Felis imperdiet proin fermentum leo vel. Curabitur gravida arcu ac tortor dignissim convallis aenean. At auctor urna nunc id cursus metus aliquam eleifend. Morbi tristique senectus et netus. Porttitor rhoncus dolor purus non enim. Orci ac auctor augue mauris augue neque gravida in. Ornare quam viverra orci sagittis eu volutpat odio. Amet porttitor eget dolor morbi non arcu risus quis. Ullamcorper morbi tincidunt ornare massa eget egestas. In cursus turpis massa tincidunt dui. Consectetur libero id faucibus nisl tincidunt. Vitae auctor eu augue ut lectus. Tempus urna et pharetra pharetra massa massa ultricies. Malesuada fames ac turpis egestas.',
  },
];