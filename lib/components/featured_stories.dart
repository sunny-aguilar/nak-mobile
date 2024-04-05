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
    return FutureBuilder(
      future: db.UserService().getData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child:Text('Error building home screen'));
        }
        else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print('snapshot.hasError 1');
            return Center(
              child: Text('An ${snapshot.error} occurred'),
            );
          }
          else if (snapshot.hasData) {
            // return the listview holding the homepage elements
            print('snapshot.hasError 2');
            return const BlogStream();
          }
        }
        else {
          print('snapshot.hasError 3');
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                strokeWidth: 10,
              ),
            ),
          );
        }
        // display default value
        print('snapshot.hasError 4');
        return const Center(
          child: SizedBox(
            height: 150,
              width: 150,
            child: CircularProgressIndicator(
              color: theme.azureClr,
            ),
          ),
        );
      },
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


class BlogStream extends StatefulWidget {
  const BlogStream({super.key});
  @override
  State<BlogStream> createState() => _BlogStreamState();
}


class _BlogStreamState extends State<BlogStream> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('blog').orderBy('date', descending: true).snapshots();

  CircularProgressIndicator circularProgress() {
    return const CircularProgressIndicator(
      strokeWidth: 5,
      color: theme.azureClr,
      backgroundColor: theme.greyClr,
    );
  }

  ListView buildBlogList(snapshot) {
    // list to hold carousel
    List<Widget> carouselList = [
      const carousel.CarouselComponent(),
      const SizedBox(height: 4,),
    ];

    // get blog data, create card templates, save to list
    List<Widget> blogList = snapshot.data!.docs.map<Widget>( (DocumentSnapshot document) {
      String defaultUserImg = 'https://firebasestorage.googleapis.com/v0/b/nak-app-a899e.appspot.com/o/selfies%2Fprofile.webp?alt=media&token=9a3346e1-069e-4878-aa43-54394a368a5e';

      // get data from blog snapshot
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;


      return GestureDetector(
        onTap: () {
          /* go to page */
          /* might want to add edit/delete options */
        },

        child: FutureBuilder(
          future: db.BlogDB(docID: data['docID']).getBlogUser(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error building home screen'),);
            }
            else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'An ${snapshot.error} occurred. Please notify us at developer@nakinc.org.'
                  ),
                );
              }
              else if (snapshot.hasData) {
                // return the listview holding the homepage elements
                final dataforUser = snapshot.data;
                return cards.StoryCardNetwork(
                  userImage: dataforUser!['selfie'] ?? defaultUserImg,      // userData is comes from FutureBuilder
                  userName: data['name'],
                  storyHeadline: data['title'],
                  image: data['url'],
                  storyText: data['body'],
                  date: data['date'],
                );
              }
            }
            else {
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ),
                ),
              );
            }
            // display default value
            return const Center(
              child: SizedBox(
                height: 150,
                  width: 150,
                child: CircularProgressIndicator(
                  color: theme.azureClr,
                ),
              ),
            );


          },
        ),
      );
    }).toList();


    // combine the lists
    List<Widget> combinedList = carouselList + blogList;

    // create a listview for the list
    ListView myList = ListView(
      children: combinedList,
    );

    // return the list
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      // initialData: 'string',
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // check for errors
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return circularProgress();
        // }
        // else if (snapshot.connectionState == ConnectionState.active) {
        //   if (snapshot.hasError) {
        //     return const Center(child: Text('Oh no! An error occurred!'),);
        //   }
        //   else if (!snapshot.hasData) {
        //     return circularProgress();
        //   }
        //   else if (snapshot.hasData) {
        //     return buildBlogList(snapshot);
        //   }
        // }
        // return Text('State: ${snapshot.connectionState}');

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return circularProgress();
          case ConnectionState.active:
            return buildBlogList(snapshot);
          case ConnectionState.done:
            return const Center(child: Text('Oh no! An error occurred!'),);
        }
      }
    );
  }
}

class BuildBlog extends StatelessWidget {
  const BuildBlog({super.key});


ListView buildBlogList(snapshot) {
    // list to hold carousel
    List<Widget> carouselList = [
      const carousel.CarouselComponent(),
      const SizedBox(height: 4,),
    ];

    // get blog data, create card templates, save to list
    List<Widget> blogList = snapshot.data!.docs.map<Widget>( (DocumentSnapshot document) {
      String defaultUserImg = 'https://firebasestorage.googleapis.com/v0/b/nak-app-a899e.appspot.com/o/selfies%2Fprofile.webp?alt=media&token=9a3346e1-069e-4878-aa43-54394a368a5e';

      // get data from blog snapshot
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;


      return GestureDetector(
        onTap: () {
          /* go to page */
          /* might want to add edit/delete options */
        },

        child: FutureBuilder(
          future: db.BlogDB(docID: data['docID']).getBlogUser(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error building home screen'),);
            }
            else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'An ${snapshot.error} occurred. Please notify us at developer@nakinc.org.'
                  ),
                );
              }
              else if (snapshot.hasData) {
                // return the listview holding the homepage elements
                final dataforUser = snapshot.data;
                return cards.StoryCardNetwork(
                  userImage: dataforUser!['selfie'] ?? defaultUserImg,      // userData is comes from FutureBuilder
                  userName: data['name'],
                  storyHeadline: data['title'],
                  image: data['url'],
                  storyText: data['body'],
                  date: data['date'],
                );
              }
            }
            else {
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ),
                ),
              );
            }
            // display default value
            return const Center(
              child: SizedBox(
                height: 150,
                  width: 150,
                child: CircularProgressIndicator(
                  color: theme.azureClr,
                ),
              ),
            );


          },
        ),
      );
    }).toList();


    // combine the lists
    List<Widget> combinedList = carouselList + blogList;

    // create a listview for the list
    ListView myList = ListView(
      children: combinedList,
    );

    // return the list
    return myList;
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}