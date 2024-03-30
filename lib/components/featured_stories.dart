import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:nak_app/components/carousel.dart' as carousel;
import 'package:nak_app/components/cards.dart' as cards;
import 'package:nak_app/db/home_db.dart' as home_db;
import 'package:nak_app/ui/theme.dart' as theme;

/* This widget adds the featured stories in the home page */

class HomeScreenChildren extends StatelessWidget {
  const HomeScreenChildren({super.key});
  @override
  Widget build(BuildContext context) {
    return BlogStream();
    // return ListView(
    //   controller: controller,
    //   // children: childrenList(home_db.storyCardData),
    //   children: BlogStream(),
    // );
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
    // storyList.add(card.LargeGreyPictureCard(
    //   userImage: userImage,
    //   userName: userName,
    //   storyHeadline: storyHeadline,
    //   image: image,
    //   date: date,
    //   storyText: storyText,
    // ));
    // storyList.add(const SizedBox(height: 15,));
  }

  // storyList.add(BlogStream(storyList: storyList));
}



class BlogStream extends StatefulWidget {
  const BlogStream({super.key});
  // final List<Widget> storyList;
  @override
  State<BlogStream> createState() => _BlogStreamState();
}

class _BlogStreamState extends State<BlogStream> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('blog').snapshots();

  CircularProgressIndicator circularProgress() {
    return const CircularProgressIndicator(
      strokeWidth: 5,
      color: theme.azureClr,
      backgroundColor: theme.greyClr,
    );
  }

  ListView buildBlogList(snapshot) {
    QuerySnapshot querySnapshot = snapshot.data;
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    final List<DocumentSnapshot> queryDocuments = snapshot.data.docs;
    // final x = docs.map( (doc) => print(doc['name']) );
    // var items = snapshot.data.docs[0];

    List<Widget> carouselList = [
      const carousel.CarouselComponent(),
      const SizedBox(height: 4,),
    ];

    // get blog data, create card templates, save to list
    List<Widget> blogList = snapshot.data!.docs.map<Widget>( (DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        return GestureDetector(
          onTap: () { /* go to page */},
          child: cards.StoryCardNetwork(
            userImage: 'assets/img/users/profile.webp',
            userName: data['name'],
            storyHeadline: data['title'],
            image: data['url'],
            storyText: data['body'],
            date: data['date'],
          ),
        );
    }).toList();

    // combine the lists
    List<Widget> finalList = carouselList + blogList;

    // create a listview for the list
    ListView myList = ListView(
      children: finalList,
    );

    // return the list
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // check for errors
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return circularProgress();
          case ConnectionState.active:
            return buildBlogList(snapshot);
          case ConnectionState.done:
            return const Placeholder();
        }

      }
    );
  }
}