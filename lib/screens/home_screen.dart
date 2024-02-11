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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
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
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // const SizedBox(
          //   height: 0.0,
          // ),
          // Image.asset("assets/img/nak-letters.png", height: 100.0,),
          Text(
            "Home Page",
          ),
        ],
      ),
    );
  }
}