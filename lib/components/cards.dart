import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/screens/neb_screen.dart';
import 'package:nak_app/screens/blog/edit_blog.dart' as edit_blog;


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
    // dropdown variables

    return GestureDetector(
      onTap: () {

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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        title: Text(userName.toUpperCase(), style: theme.TextThemes.blogAuthorNames(context)),
                        // subtitle: Text(storyHeadline, style: theme.TextThemes.monoBodyBoldSmall18(context)),
                        subtitle: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              // TextSpan(text: '$storyHeadline\n', style: theme.TextThemes.monoBodyBoldSmall18(context)),
                              TextSpan(text: date, style: theme.TextThemes.blogDate(context))
                            ]
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(color: theme.dividerClr,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(storyHeadline, style: theme.TextThemes.monoBodyBold600Med24(context)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(storyText, style: theme.TextThemes.monoBodySmall18(context)),
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
      child: Card.outlined(
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
                  // fontFamily: 'Diatype'
                ),
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
      ),
    );
  }
}


class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key});
  @override
  State<PopupMenu> createState() => _PopupMenuState();
}


class _PopupMenuState extends State<PopupMenu> {
  // SampleItem? selectedItem;

  PopupMenuItem _buildPopupMenuItem(String title, IconData iconData, String action) {
    return PopupMenuItem(
      onTap: () {

        if (action == 'edit') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const edit_blog.BlogList();
              },
            )
          );
        }
        else if (action == 'delete') {
          print('Replace me: delete blog entry');
        }

      },
      child: ListTile(
        leading: Icon(iconData),
        title: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // initialValue: selectedItem,
      onSelected: (item) {},
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          _buildPopupMenuItem('Edit', Icons.create_outlined, 'edit'),
          _buildPopupMenuItem('Delete', Icons.delete_outline, 'delete'),
        ];
      },
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
                  BlendMode.overlay,
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
              style: theme.TextThemes.headlineLarge28(context),
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


// Board member cards displayed in the 'National Board' menu
// NEB data is populated by a JSON file saved on the developer Google drive
// NEB images are stored in the project assets folder
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

        // NEB user info
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


class ChapterFinancesCard extends StatelessWidget {
  const ChapterFinancesCard({
    super.key, required this.title, required this.cardIcon, required this.screen, required this.desc, required this.modalText});
  final String title;
  final IconData cardIcon;
  final Function screen;
  final String desc;
  final String modalText;

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: theme.TextThemes.headlineSmall20(context),),
          content: Text(modalText),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: theme.TextThemes.headlineSmall20(context),
              ),
              child: const Text('Dismiss', style: TextStyle(color: theme.redClr),),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: theme.redClr,
        onTap: () {
          // go to corresponding finance screen
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) {
                return screen();
              }
            )
          );
        },
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(width: 20,),
                Icon(cardIcon, size: 50, color: theme.redOfficial,),
                const SizedBox(width: 50,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: theme.TextThemes.headlineSmall20(context),),
                    Text(desc),
                    const Text('2024 - 2025 Academic Year'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 20,),
                GestureDetector(
                  onTap: () {
                    _dialogBuilder(context);
                    // add a bottom modal card
                  },
                  child: const Icon(Icons.help_outline_outlined, size: 30, color: theme.bronzeOfficial,)
                ),
                const SizedBox(width: 20,),
                // const Text('Like'),
                // const SizedBox(width: 50,),
                // const Icon(Icons.mode_comment_outlined, size: 30,),
                // const SizedBox(width: 10,),
                // const Text('Comment'),
              ],
            ),
            const SizedBox(height: 15,),
          ],
        ),
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