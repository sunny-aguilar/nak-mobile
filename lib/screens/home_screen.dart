import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/img/nak-letters.png", height: 30.0,),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Image.asset("assets/img/rush_nak.png",)),
              // Text(
              //   "Home Page",
              // ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Home Page",
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            "assets/img/rush_nak.png",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          Container(width: 20.0,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(height: 5.0,),
                                const Text(
                                  "Cards Title 1",
                                ),
                                Container(height: 5.0,),
                                const Text(
                                  "Sub title"
                                ),
                                Container(height: 10.0,),
                                const Text(
                                  "Another text"
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}