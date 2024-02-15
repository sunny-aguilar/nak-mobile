import 'package:flutter/material.dart';

class RedOutlineCard extends StatelessWidget {
  const RedOutlineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: const Color.fromARGB(175, 196, 18, 48),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(175, 196, 18, 48), width: 3,
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
      color: const Color.fromARGB(175, 196, 18, 48),
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
                  backgroundColor: const Color.fromARGB(255, 103, 163, 177),
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
      height: 160,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        // color: const Color.fromARGB(255, 235, 181, 248),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 180,
          height: 140,
          color: const Color.fromARGB(255, 235, 181, 248),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/img/image_wireframe2.png",
                  height: 80,
                  color: const Color.fromARGB(255, 213, 109, 235),
                  colorBlendMode: BlendMode.modulate,
                )
              ),
              Text(
                "Headline",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
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
        Row(
          children: <Widget>[
            SimpleCard(),
          ],
        ),
      ],
    );
  }
}

class SimpleCard extends StatelessWidget {
  const SimpleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 220,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        // color: const Color.fromARGB(255, 235, 181, 248),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Center(
        child: Container(
          color: Colors.red,
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}