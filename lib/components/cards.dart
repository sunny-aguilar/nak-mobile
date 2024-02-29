import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    text: "Red Outline Card",
                    style: TextStyle(
                      color: Color.fromARGB(175, 196, 18, 48),
                      fontSize: 20,
                      fontFamily: "HelveticaNeue",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: const Text(
              "Read the latest state of the fraternity union.",
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
                  "KEEP READING",
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

class RedCard extends StatelessWidget {
  const RedCard ({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(175, 254, 58, 67),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.stacked_bar_chart,
              color: Colors.white.withAlpha(255),
            ),
            title: RichText(
              text: TextSpan(
                // style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "Red Solid Card",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 20,
                      fontFamily: "HelveticaNeue",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () => {},
                child: Text(
                  "KEEP READING",
                  style: TextStyle(
                    color: Colors.white.withAlpha(255),
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

class LeftClippedCard extends StatelessWidget {
  const LeftClippedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3)
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color.fromARGB(255, 32, 190, 199), width: 8,
              ),
            ),
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
                        text: "Left Styled Card",
                        style: TextStyle(
                          color: Color.fromARGB(255, 200, 183, 131),
                          fontSize: 20,
                          fontFamily: "HelveticaNeue",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: const Text(
                  "Read the latest state of the fraternity union.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 200, 183, 131),
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
                      "KEEP READING",
                      style: TextStyle(
                        color: Color.fromARGB(255, 200, 183, 131),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlueGreyCard extends StatelessWidget {
  const BlueGreyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(
          Icons.message_outlined,
          color: Color.fromARGB(255, 103, 163, 177)
        ),
        title: Text("President's Message"),
        subtitle: Text("Come read about the state of the fraternity."),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}

class SolidBronzeCard extends StatelessWidget {
  const SolidBronzeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromARGB(255, 200, 183, 131),
      child: ListTile(
        leading: const Icon(Icons.favorite),
        title: const Text("Solid Bronze Card"),
        subtitle: const Text("This is the ListTile subtitle that should be three lines long."),
        isThreeLine: false,
        dense: false,
        trailing: const Icon(Icons.account_balance),
        onTap: () => {},
      ),
    );
  }
}

class ClippedCard extends StatelessWidget {
  const ClippedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 130,
                color: const Color.fromARGB(0, 255, 255, 255),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                ),
                child: Container(
                  height: 100,
                  color: Colors.blue,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LargeGreyPictureCard extends StatelessWidget {
  final String imageString;
  const LargeGreyPictureCard({super.key, required this.imageString});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          ListTile(
            // leading: const Icon(Icons.more_vert),
            title: const Text('Large Grey Image Card'),
            subtitle: Text(
              'January 13, 2024',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          Image.asset(
            imageString,
            fit: BoxFit.fill,
            scale: 1,
            // alignment: const Alignment(0, 0),
            width: double.infinity,
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vel congue enim, sed consequat dui.',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 254, 58, 67),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Perform some action
                },
                child: const Text('KEEP READING'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GradientCard extends StatelessWidget {
  const GradientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // tileMode: TileMode.repeated,
            colors: <Color>[
              // Color.fromARGB(255, 196, 18, 48),
              // Color.fromARGB(255, 255, 255, 255),
              // Color.fromARGB(255, 200, 183, 131),
              // Color.fromARGB(255, 103, 163, 177),
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ]
          ),
        ),
        child: ListTile(
          leading: const Icon(Icons.arrow_drop_down_circle),
          title: const Text('Purple Red Orange Gradient Card'),
          subtitle: Text(
            'Secondary Text',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }
}

class PurpleCard extends StatelessWidget {
  const PurpleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Color.fromARGB(255, 109, 42, 255),
      child: ListTile(
        leading: Icon(
          Icons.message_outlined,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: Text(
          "Purple Round Edge Card",
          style: TextStyle(

            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        subtitle: Text(
          "Come read about the state of the fraternity.",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

class PurpleSquareCard extends StatelessWidget {
  const PurpleSquareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color.fromARGB(255, 109, 42, 255),
      child: ListTile(
        leading: Icon(
          Icons.message_outlined,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: Text(
          "Purple Square Card",
          style: TextStyle(

            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        subtitle: Text(
          "Come read about the state of the fraternity.",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

class RedSquareCard extends StatelessWidget {
  const RedSquareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      // color: Color(0xfffe3a43),
      color: Color.fromARGB(255, 254, 58, 67),
      child: ListTile(
        leading: Icon(
          Icons.message_outlined,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: Text(
          "Red Square Card",
          style: TextStyle(

            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        subtitle: Text(
          "Come read about the state of the fraternity.",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

class WhiteRedAccentCard extends StatelessWidget {
  const WhiteRedAccentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      // color: Color(0xfffe3a43),
    color: Color.fromARGB(255, 255, 255, 255),
      child: ListTile(
        leading: Icon(
          Icons.message_outlined,
          color: Color.fromARGB(255, 254, 58, 67),
        ),
        title: Text(
          "White Red Accent Card",
          style: TextStyle(
            color: Color.fromARGB(255, 28, 28, 28),
          ),
        ),
        subtitle: Text(
          "Come read about the state of the fraternity.",
          style: TextStyle(
            color: Color.fromARGB(255, 28, 28, 28),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Color.fromARGB(255, 31, 31, 31),
        ),
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
          "Light Gray Card",
          style: TextStyle(
            color: Color.fromARGB(255, 28, 28, 28),
          ),
        ),
        subtitle: Text(
          "Come read about the state of the fraternity.",
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
                      "assets/img/image_wireframe2.png",
                      height: 90,
                      color: const Color.fromARGB(255, 213, 109, 235),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                ),
              ),
              Text(
                "Headline",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                "Here is a card description",
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
  var subheading = 'Established: ${chapters[index]["established"]}\nstatus: ${chapters[index]["status"]}';
  var supportingText = '${chapters[index]["contact"]}';

  return Card(
    child: ListTile(
      leading: Image.asset(
        cardImage,
        width: 60.0,
      ),
      title: Text(
        heading,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: const Color.fromARGB(255, 45, 45, 45),
        ),
      ),
      subtitle: Text(
        subheading,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: const Color.fromARGB(255, 45, 45, 45),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          showModalBottomSheet(
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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(),
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
  var buttonLink = '${dues[index]['url']}';
  return Card(
      elevation: 2.0,
      child: Column(
        children: [
        //  ListTile(
        //    title: Text(heading),
        //    subtitle: Text(subheading),
        //    trailing: Icon(Icons.favorite_outline),
        //  ),
          SizedBox(
          height: 200.0,
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
                  // BlendMode.overlay,
                  // BlendMode.darken,
                  // BlendMode.lighten,
                  // BlendMode.colorDodge,
                  // BlendMode.colorBurn,
                  // BlendMode.hardLight,
                  // BlendMode.softLight,
                  // BlendMode.difference,
                  // BlendMode.exclusion,
                  // BlendMode.multiply,
                  BlendMode.hue,
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
              style: Theme.of(context).textTheme.displayMedium,
            ),
            subtitle: Text(
              subheading,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          //  trailing: Icon(Icons.favorite_outline),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(supportingText),
          ),
          ButtonBar(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(160, 46),
                  backgroundColor: const Color.fromARGB(255, 254, 58, 67),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                child: const Text('PAY DUES'),
                onPressed: () {
                  Future<void> launchUrlStart({required String url}) async {
                    if (!await launchUrl(Uri.parse(url))) {
                      throw 'Could not launch $url';
                    }
                  }
                  launchUrlStart(url: buttonLink);
                },
              )
            ],
          )
        ],
      ));
 }

 Card boardCard({required BuildContext context, required int index, required List board}) {
  var cardImage = 'assets/img/board_headshot.png';
  var heading = '${board[index]["position"]}';
  var subheading = '${board[index]["name"]}';
  var supportingText = '${board[index]["email"]}';

  return Card(
    color: const Color.fromARGB(255, 255, 255, 255),
    elevation: 2.0,
    child: Column(
      children: <Widget>[
        SizedBox(
          // height: 200,
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
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(),
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