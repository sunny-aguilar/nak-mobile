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
              "Music by Julie Gable. Lyrics by Sidney Stein.",
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
      child:ListTile(
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
        leading: Icon(Icons.favorite),
        title: Text("ListTile Title"),
        subtitle:Text("This is the ListTile subtitle that should be three lines long."),
        isThreeLine: false,
        dense: false,
        trailing: Icon(Icons.account_balance),
        onTap: () => {},
      ),
    );
  }
}