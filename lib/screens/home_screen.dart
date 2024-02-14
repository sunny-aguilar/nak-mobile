import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/img/nak_letters.png", height: 30.0,),
        // backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                "Drawer Header",
                style: TextStyle(
                  color: Colors.white, fontSize: 24
                )
              ),
            ),
            ListTile(
              leading: const Icon(Icons.stacked_bar_chart),
              title: const Text("Intro Screen"),
              onTap: () => Navigator.pushNamed(context, "/intro"),
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text("Chapters"),
              onTap: () => Navigator.pushNamed(context, "/chapters"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("Dues"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("National Board"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("NAKstore"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("Alumni Network"),
            ),
            const ListTile(
              leading: Icon(Icons.message),
              title: Text("National Website"),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4),
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Expanded(
                child: Image.asset("assets/img/rush_nak.png", fit: BoxFit.none, scale: 3.2, alignment: const Alignment(0, -0.9), height: 300,),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          // ColoredBox(
          //   color: const Color.fromARGB(255, 200, 183, 131),
          //   child: ListTile(
          //     leading: Icon(Icons.favorite),
          //     title: Text("ListTile Title"),
          //     // subtitle:Text("This is the ListTile subtitle that should be three lines long."),
          //     isThreeLine: false,
          //     dense: false,
          //     trailing: Icon(Icons.account_balance),
          //     onTap: () => {},
          //   ),
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          // ColoredBox(
          //   color: const Color.fromARGB(255, 200, 183, 131),
          //   child: ListTile(
          //     leading: Icon(Icons.favorite),
          //     title: Text("ListTile Title"),
          //     subtitle:Text("This is the ListTile subtitle that should be three lines long."),
          //     isThreeLine: false,
          //     dense: false,
          //     trailing: Icon(Icons.account_balance),
          //     onTap: () => {},
          //   ),
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          Card(
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
                          text: "Red Card",
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
          ),
          Card(
            // color: const Color.fromARGB(175, 196, 18, 48),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Color.fromARGB(175, 196, 18, 48),
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
                          text: "Red Card",
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
          ),
          const Card(
            child:ListTile(
              leading: Icon(
                Icons.message_outlined,
                color: Color.fromARGB(255, 103, 163, 177)
              ),
              title: Text("President's Message"),
              subtitle: Text("Come read about the state of the fraternity."),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
          const Card(
            child:ListTile(
              leading: Icon(
                Icons.message_outlined,
                color: Color.fromARGB(255, 103, 163, 177)
              ),
              title: Text("President's Message"),
              subtitle: Text("Come read about the state of the fraternity."),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
          const Card(
            child:ListTile(
              leading: Icon(
                Icons.message_outlined,
                color: Color.fromARGB(255, 103, 163, 177)
              ),
              title: Text("President's Message"),
              subtitle: Text("Come read about the state of the fraternity."),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
            ),
          ),
          Card(
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
                      color: Color.fromARGB(255, 200, 183, 131), width: 8,
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
                              text: "President's Message",
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
          ),
          Card(
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
                          text: "President's Message",
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
          ),
          Card(
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
                          text: "President's Message",
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
          ),
          const Card(
            color: Color.fromARGB(175, 196, 18, 48),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 120,
                  child: Text("SIZED BOX"),
                ),
              ],
            ),
          ),
          Card(
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
          ),
        ],
      ),
    );
  }
}