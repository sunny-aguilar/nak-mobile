import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nak_app/components/carousel.dart' as carousel;
import 'package:nak_app/components/cards.dart' as cards;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;

/* This widget adds the featured stories in the home page */

class HomeScreenChildren extends StatelessWidget {
  const HomeScreenChildren({super.key});
  @override
  Widget build(BuildContext context) {
    return const BlogStream();
  }
}


class BlogStream extends StatefulWidget {
  const BlogStream({super.key});
  @override
  State<BlogStream> createState() => _BlogStreamState();
}


class _BlogStreamState extends State<BlogStream> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('blog').orderBy('date', descending: true).snapshots();

  Center _circularProgress() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:  60.0),
        child: SizedBox(
          height: 50, width: 50,
          child: CircularProgressIndicator(
            strokeWidth: 7,
            color: theme.redClr,
            backgroundColor: theme.bronzeOfficial,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        // list to for ListView (will hold all home screen widgets (carousel + blog))
        List<Widget> clientWidgets = [];

        // add carousel Widgetto list
        List<Widget> carouselList = [
          const carousel.CarouselComponent(),
          const SizedBox(height: 4,),
        ];

        clientWidgets += carouselList;

        if (snapshot.data == null) { return _circularProgress(); }

        if (!snapshot.hasData) { return _circularProgress(); }

        if (snapshot.hasData) {

          // list holding each blog
          final blogs = snapshot.data.docs.toList();

          // create a card widget for each blog
          for(var blog in blogs) {

            // seems to work- obtains selfie url using the Futurebuilder
            // if glitche found, you can delete FutureBuilder and uncomment the working code below
            final clientWidget =
              FutureBuilder(
                future: db.GetBlogUserSelfie().getBlogUserUID(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {return _circularProgress(); }

                  else if (snapshot.data == null) { _circularProgress(); }

                  else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

                    // obtain selfie URL from Future snapshot or assign default image if none exists
                    Map<String, String> urlMap = snapshot.data!;
                    String userSelfie;
                    if (urlMap.containsKey(blog['userUID'])) {
                      userSelfie = urlMap[blog['userUID']]!;
                    }
                    else {
                      userSelfie = 'https://firebasestorage.googleapis.com/v0/b/nak-app-a899e.appspot.com/o/selfies%2Fprofile.webp?alt=media&token=9a3346e1-069e-4878-aa43-54394a368a5e';
                    }

                    // assign Card to clientWidget
                    return cards.StoryCardNetwork(
                            userImage: userSelfie,
                            userName: blog['name'],
                            storyHeadline: blog['title'],
                            image: blog['url'],
                            storyText: blog['body'],
                            date: blog['date'],
                          );
                  }
                  return _circularProgress();
                },
              );

            // add cards to list
            clientWidgets.add(clientWidget);
          }
        }

        // return listview to to be displayed
        return ListView(
          children: clientWidgets,
        );
      }
    );
  }
}