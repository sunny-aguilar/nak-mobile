import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/screens/neb_screen.dart';

class RedOutlineCard extends StatelessWidget {
  const RedOutlineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: const Color.fromARGB(175, 196, 18, 48),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(175, 254, 58, 67), width: 3,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.stacked_bar_chart,
              color: Color.fromARGB(175, 196, 18, 48),
            ),
            title: RichText(
              text: const TextSpan(
                // style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Red Outline Card',
                    style: TextStyle(
                      color: Color.fromARGB(175, 196, 18, 48),
                      fontSize: 20,
                      fontFamily: 'HelveticaNeue',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: const Text(
              'Read the latest state of the fraternity union.',
              style: TextStyle(
                color: Color.fromARGB(175, 196, 18, 48),
                fontSize: 14,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () => {},
                child: const Text(
                  'KEEP READING',
                  style: TextStyle(
                    color: Color.fromARGB(175, 196, 18, 48),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LargeGreyPictureCard extends StatelessWidget {
  final String userImage;
  final String userName;
  final String storyHeadline;
  final String image;
  final String date;
  final String storyText;
  const LargeGreyPictureCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.storyHeadline,
    required this.image,
    required this.date,
    required this.storyText,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: const BorderSide(
          width: 1.0,
          color: theme.greyClr
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
              backgroundColor: Colors.grey,
            ),
            title: Text(
              userName,
              style: const TextStyle(
                fontFamily: 'College',
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              storyHeadline,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert,),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.whiteClr,
                  showDragHandle: true,
                  enableDrag: true,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SizedBox(
                      // height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: FractionallySizedBox(
                        heightFactor: 0.8,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // cteate a class to hold a modal template
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Divider(color: theme.dividerClr,),
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(userImage),
                                  backgroundColor: Colors.grey,
                                ),
                                title: Text(userName,),
                                subtitle: Text(storyHeadline),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Divider(color: theme.dividerClr,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(storyText),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Divider(color: theme.dividerClr),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(Icons.bookmark),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                );
              },
            ),
          ),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              scale: 1,
              width: double.infinity,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: Text(date,),
          ),
        ],
      ),
    );
  }
}


class StoryCardNetwork extends StatelessWidget {
  final String userImage;
  final String userName;
  final String storyHeadline;
  final String image;
  final String date;
  final String storyText;
  const StoryCardNetwork({
    super.key,
    required this.userImage,
    required this.userName,
    required this.storyHeadline,
    required this.image,
    required this.date,
    required this.storyText,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: const BorderSide(
          width: 1.0,
          color: theme.greyClr
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
              backgroundColor: Colors.grey,
            ),
            title: Text(
              userName,
              style: const TextStyle(
                fontFamily: 'College',
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              storyHeadline,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert,),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.whiteClr,
                  showDragHandle: true,
                  enableDrag: true,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SizedBox(
                      // height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: FractionallySizedBox(
                        heightFactor: 0.8,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // cteate a class to hold a modal template
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Divider(color: theme.dividerClr,),
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(userImage),
                                  backgroundColor: Colors.grey,
                                ),
                                title: Text(userName,),
                                subtitle: Text(storyHeadline),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Divider(color: theme.dividerClr,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(storyText),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Divider(color: theme.dividerClr),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(Icons.bookmark),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                );
              },
            ),
          ),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              image,
              fit: BoxFit.cover,
              scale: 1,
              width: double.infinity,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: Text(date,),
          ),
        ],
      ),
    );
  }
}


class LightGrayCard extends StatelessWidget {
  const LightGrayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 1,
      // color: Color.fromARGB(255, 243, 243, 243),
      shadowColor: Color.fromARGB(100, 0, 0, 0),
      child: ListTile(
        leading: Icon(
          Icons.message_outlined,
          color: Color.fromARGB(255, 254, 58, 67),
        ),
        title: Text(
          'Light Gray Card',
          style: TextStyle(
            color: Color.fromARGB(255, 28, 28, 28),
          ),
        ),
        subtitle: Text(
          'Come read about the state of the fraternity.',
          style: TextStyle(
            color: Color.fromARGB(255, 28, 28, 28),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color.fromARGB(255, 11, 0, 34),
        ),
      ),
    );
  }
}

class MiniCard extends StatelessWidget {
  const MiniCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 180,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        // color: const Color.fromARGB(255, 235, 181, 248),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: const Color.fromARGB(255, 223, 223, 223)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0.8, 1),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 180,
          height: 160,
          color: const Color.fromARGB(255, 235, 181, 248),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Image.asset(
                      'assets/img/image_wireframe2.png',
                      height: 90,
                      color: const Color.fromARGB(255, 213, 109, 235),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                ),
              ),
              Text(
                'Headline',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                'Here is a card description',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridCards extends StatelessWidget {
  const GridCards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            MiniCard(),
            Spacer(),
            MiniCard(),
          ],
        ),
        SizedBox(height: 12,),
        Row(
          children: <Widget>[
            MiniCard(),
            Spacer(),
            MiniCard(),
          ],
        ),
      ],
    );
  }
}

Card chapterCard({required BuildContext context, required int index, required List chapters}) {
  var cardImage = 'assets/img/chapters/$index.png';
  var heading = '${chapters[index]["name"]}';
  var subheading = 'Established: ${chapters[index]["established"]}\nStatus: ${chapters[index]["status"]}';
  var supportingText = '${chapters[index]["contact"]}';

  return Card(
    color: Theme.of(context).primaryColor,
    child: ListTile(
      leading: Image.asset(
        cardImage,
        width: 60.0,
      ),
      title: Text(
        heading,
        style: theme.TextThemes.chapterCardTitle(context),
      ),
      subtitle: Text(
        subheading,
        style: theme.TextThemes.headline(context),
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert, color: Get.isDarkMode ? theme.whiteClr : theme.darkGreyClr),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.whiteClr,
            showDragHandle: true,
            enableDrag: true,
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 120,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(Icons.email),
                    Text(
                      supportingText,
                      style: theme.TextThemes.modalText(context),
                    ),
                  ],
                ),
              );
            }
          );
        },
      ),
    )
  );
}

Card duesCard({required BuildContext context, required int index, required List dues}) {
  var cardImage = '${dues[index]["picURL"]}';
  var heading = '${dues[index]["name"]}';
  var subheading = '${dues[index]["amount"]}';
  var supportingText = '${dues[index]['description']}';
  var url = '${dues[index]['url']}';
  return Card.outlined(
    color: Theme.of(context).primaryColor,
    // color: theme.offWhiteClr,
      elevation: 2.0,
      child: Column(
        children: [
          SizedBox(
          height: 180.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Material(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                Colors.grey,
                  // BlendMode.modulate,
                  // BlendMode.screen,
                  BlendMode.overlay,
                  // BlendMode.darken,
                  // BlendMode.lighten,
                  // BlendMode.colorDodge,
                  // BlendMode.colorBurn,
                  // BlendMode.hardLight,
                  // BlendMode.softLight,
                  // BlendMode.difference,
                  // BlendMode.exclusion,
                  // BlendMode.multiply,
                  // BlendMode.hue,
                  // BlendMode.saturation,
                  // BlendMode.color,
                  // BlendMode.luminosity,
                ),
                child: Image.asset(
                  cardImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ),
          ListTile(
            title: Text(
              heading,
              style: theme.TextThemes.duesTitle(context),
            ),
            subtitle: Text(
              subheading,
              style: theme.TextThemes.headlineMed(context),
            ),
          //  trailing: Icon(Icons.favorite_outline),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(supportingText, style: theme.TextThemes.headline(context),),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Get.isDarkMode ? buttons.RedOutlineButton(text: 'PAY DUES', url: url) : buttons.RedButton(text: 'PAY DUES', url: url),
          ),
        ],
      )
    );
 }

 Card boardCard({required BuildContext context, required int index, required Boardmember board}) {
  var cardImage = board.image;
  var heading = board.position;
  var subheading = board.name;
  var supportingText = board.email;

  return Card(
    color: Theme.of(context).primaryColor,
    elevation: 2.0,
    child: Column(
      children: <Widget>[
        SizedBox(
          // height: 200,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              cardImage,
              fit: BoxFit.cover,
              height: 180.0,
            ),
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          minVerticalPadding: 0,
          visualDensity: VisualDensity.compact,
          dense: true,
          title: Text(
            heading,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            subheading,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.whiteClr,
                showDragHandle: true,
                enableDrag: true,
                context: context,
                builder: (BuildContext context  ) {
                  return SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.email),
                        Text(
                          supportingText,
                          style: theme.TextThemes.modalText(context),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
 }

class RevampedCard extends StatelessWidget {
  const RevampedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 73, 91, 120)
            ),
            child: const Text('TOP CONTAINER'),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 210,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 22, 22, 30),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)
              ),
            ),
            child: const Text('BOTTOM CONTAINER'),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});
  @override
  Widget build(BuildContext context) {
    String alertDate = DateFormat.yMMMMd('en_US').format(DateTime.now());

    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
      decoration: const BoxDecoration(
        color: theme.blueClr,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alertDate,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lato',
                          color: theme.primaryClr,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.access_time_rounded, size: 18, color: theme.primaryClr,),
                          SizedBox(width: 4,),
                          Text(
                            'Task to be done',
                            style: TextStyle(fontSize: 13, color: theme.primaryClr),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      const Text(
                        'A note to be taken.',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Lato',
                          color: theme.primaryClr,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 0.5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              const RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'Task is complete',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 10,
                    color: theme.primaryClr,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8,),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: theme.greyClr,
        dateTextStyle: const TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          // color: theme.darkGreyClr,
        ),
        monthTextStyle: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 12,
          // fontWeight: FontWeight.bold,
        ),
        dayTextStyle: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 14,
          // fontWeight: FontWeight.bold,
          // color: theme.darkGreyClr,
        ),
      ),
    );
  }
}


//  class MasonryGridTile extends StatelessWidget {
//   final String image;
//   final String title;
//   const MasonryGridTile({super.key, required this.image, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         // color: const Color(0xff534343), // adds background color to entire card
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(10.0),
//               topRight: Radius.circular(10.0),
//               bottomLeft: Radius.circular(10.0),
//               bottomRight: Radius.circular(10.0)
//             ),
//             // child: ColoredBox(
//               // color: Color(0xff534343),
//               child: Image(
//                 image: AssetImage(image),
//                 // width: 186,
//               ),
//             // ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 17,
//                         color: Color.fromRGBO(74, 74, 74, 1)),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.download,
//                         color: Colors.teal,
//                       )
//                     )
//                   ],
//                 ),
//                 const Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
//                   style: TextStyle(
//                       fontSize: 12, color: Color.fromRGBO(133, 133, 133, 1)),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ScreenArguments {
//   final String title;
//   final String lettersImg;
//   final Map policyTxt;
//   ScreenArguments({required this.title, required this.lettersImg, required this.policyTxt});
// }

// class MasonryGridTileV2 extends StatelessWidget {
//   final String image;
//   final String title;
//   final String route;
//   final String lettersImg;
//   final Map policyTxt;
//   const MasonryGridTileV2({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.route,
//     required this.lettersImg,
//     required this.policyTxt
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.pushNamed(
//         context,
//         route,
//         arguments: ScreenArguments(
//           title: title,
//           lettersImg: lettersImg,
//           policyTxt: policyTxt,
//         ),
//       ),
//       child: Card(
//         // decoration: BoxDecoration(
//         //   borderRadius: BorderRadius.circular(8.0),
//         //   // color: const Color(0xff534343), // adds background color to entire card
//         // ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10.0),
//                 topRight: Radius.circular(10.0),
//                 bottomLeft: Radius.circular(10.0),
//                 bottomRight: Radius.circular(10.0)
//               ),
//               // child: ColoredBox(
//                 // color: Color(0xff534343),
//                 child: Image(
//                   image: AssetImage(image),
//                   // width: 186,
//                 ),
//               // ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ListTile( // MIGHT BE BEST TO USE AN EXPANDED WIDGET TO HOLD THE TEXT
//                     // contentPadding: EdgeInsets.all(0),
//                     title: Text(
//                       title,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: Color.fromRGBO(74, 74, 74, 1)
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }