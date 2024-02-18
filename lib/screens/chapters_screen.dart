import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


class ChapterScreen extends StatelessWidget {
  const ChapterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   // title: Image.asset("assets/img/nak_letters_bw.png", height: 30.0,),
      //   title: const Text("NAK"),
      // ),
      body: ChapterScreens(),
    );
  }
}

class ChapterScreens extends StatefulWidget {
  const ChapterScreens({super.key});
  @override
  State<ChapterScreens> createState() => _ChapterScreensState();
}

class _ChapterScreensState extends State<ChapterScreens> {
  List _chapters = [];
  Future<void> readJson() async{
    // can JSON file be loaded from an online source?
    final String response = await rootBundle.loadString("assets/json/chapters.json");
    final data = await json.decode(response);
    setState( () => _chapters = data["chapters"] );
  }
  @override
  void initState() {
    super.initState();
    readJson();
  }
  @override
  Widget build(BuildContext context) {
    int items = _chapters.length;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Image.asset("assets/img/nak_letters_bw.png", height: 30.0,),
          backgroundColor: const Color.fromARGB(255, 254, 58, 67),
          pinned: true,
          floating: false,
          snap: false,
          stretch: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const <StretchMode>[
              StretchMode.blurBackground,
            ],
            background: Image.asset(
              "assets/img/chapter_letters.png",
              fit: BoxFit.contain,
              height: 100,
            ),
          ),
        ),
        ChapterCards(items: items, chapters: _chapters),
      ],
    );
  }
}

class ChapterCards extends StatelessWidget {
  final int items;
  final List chapters;
  const ChapterCards({super.key, required this.items, required this.chapters});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                "assets/img/chapters/$index.png",
                width: 60.0,
              ),
              title: Text(
                chapters[index]["name"],
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color.fromARGB(255, 45, 45, 45),
                ),
              ),
              subtitle: Text(
                "Established: ${chapters[index]["established"]}\nstatus: ${chapters[index]["status"]}",
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
                              "${chapters[index]["contact"]}",
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
        },
        childCount: items,
      ),
    );
  }
}

// class ChapterCardList extends StatelessWidget {
//   const ChapterCardList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return Card(
//             child: ListTile(
//               leading: const Text(
//                 "Leading"
//               ),
//               title: Text(
//                 "Leading Title Text",
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                   color: const Color.fromARGB(255, 45, 45, 45),
//                 ),
//               ),
//               subtitle: const Text(
//                 "Subtitle text"
//               ),
//               trailing: const Text(
//                 "Trailing"
//               ),
//             )
//           );
//         },
//         childCount: 26,
//       ),
//     );
//   }
// }

// ElevatedButton(
//   onPressed: () => Navigator.pop(context),
//   child: const Text("Go Back"),
// )