import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/screens/directory/chart.dart' as chart;
import 'package:nak_app/screens/directory/directory_model.dart' as db;


class Directory extends StatefulWidget {
  const Directory({super.key});
  @override
  State<Directory> createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory> {
  void _handleThemeChange() => setState((){});
  late int chapterCount = 0;

  void initializeBroData() async {
    // Prints all chapters (docs) in collection (directory)
    // final chapterList = await db.Directory().getChapters();
    // print(chapterList[0].data());
    // for (final ele in chapterList) {
    //   print('Ele: ${ele.data()}');
    // }

    // Returns specified chapter data
    // final chapter = await db.Directory().getChapter('01.alpha');
    // print('Brother: ${chapter['brother']}');

    // Initialize chapter count
    print('Total Chapters: ${await db.Directory().getChapterCount()}');

    // Get chapter count and rebuild widget #OPTION 1
    db.Directory().getChapterCount().then((val) {
      chapterCount = val;
      setState((){});
    });

    // Get chapter count and rebuild widget #OPTION 2
    // chapterCount = await db.Directory().getChapterCount();
    // setState((){});

    // Initialize bro count
    db.Directory().getBroCount();
  }

  @override
  void initState() {
    super.initState();
    // db.Directory().getChaptersTest();
    // final chapterList = await db.Directory().getChapters();
    // print(chapterList);
    initializeBroData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 38,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      // backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
      body: DirectoryDashboard(onChange: _handleThemeChange, chapterCount: chapterCount,),
    );
  }
}


class DirectoryDashboard extends StatefulWidget {
  const DirectoryDashboard({super.key, required this.onChange, required this.chapterCount});
  final Function onChange;
  final int chapterCount;
  @override
  State<DirectoryDashboard> createState() => _DirectoryDashboardState();
}

class _DirectoryDashboardState extends State<DirectoryDashboard> {
  List<double> chapterBrothers = [
    100,120,90,150,110,70,
    50,110,130,140,120,80,
    90,60,100,130,70,60,
    110,120,90,150,80,130,
    60,100,120,20
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text(
              'Brother Directory',
              style: theme.TextThemes.gabaritoSize40(context),
            ),

            // Row for graph
            //
            //
            //
            Stack(
              children: <Widget>[
                SizedBox(
                  height: 170,
                  width: MediaQuery.sizeOf(context).width,
                  child: Card(
                    color: Get.isDarkMode ? theme.uiRedClr : theme.uiGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: chart.MyBarGraph(chapterBrothers: chapterBrothers,),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 12,
                  child: Text('Brothers at each chapter', style: TextStyle(color: theme.primaryClr),)
                ),
              ],
            ),
            const SizedBox(height: 30,),

            // Row for brother metrics
            //
            //
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  width: MediaQuery.sizeOf(context).width * .450,
                  child: Card(
                    color: Get.isDarkMode ? theme.greyUI : theme.uiGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('3,001', style: theme.TextThemes.size36(context).copyWith(fontWeight: FontWeight.bold),),
                        Text('Total Brothers')
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: MediaQuery.sizeOf(context).width * .450,
                  child: Card(
                    color: Get.isDarkMode ? theme.greyUI : theme.uiGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.chapterCount.toString(), style: theme.TextThemes.size36(context).copyWith(fontWeight: FontWeight.bold),),
                        Text('Total Chapters')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),

            // Row for viewing/adding brothers
            //
            //
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 220,
                  width: MediaQuery.sizeOf(context).width * .450,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    color: Get.isDarkMode ? theme.greyUI : theme.primaryClr,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset('assets/img/ad_dues.webp'),
                        ListTile(
                          title: const Text('View Brothers', style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text('Find brothers listed by chapter.', style: theme.TextThemes.size11(context),),
                        ),
                        // add navigator here to go to the next page
                        //
                        //
                        //
                        //
                        //
                        // add navigator here to go to the next page
                      ]
                    ),
                  ),
                ),
                SizedBox(
                  height: 220,
                  width: MediaQuery.sizeOf(context).width * .45,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    color: Get.isDarkMode ? theme.greyUI : theme.primaryClr,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset('assets/img/ad_dues.webp'),
                        ListTile(
                          title: const Text('Add a Brother', style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text('Don\'t see a name? Add the bro to the directory!', style: theme.TextThemes.size11(context),),
                        ),
                        // add navigator here to go to the next page
                        //
                        //
                        //
                        //
                        //
                        // add navigator here to go to the next page
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}














class ChapterList extends StatefulWidget {
  const ChapterList({super.key});
  @override
  State<ChapterList> createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {
  List _chapters = [];
  late Future<String> _download;

  Future<String> _readJson() async{
    // json loaded externally from G drive, developer@nakinc.org
    String url = 'https://drive.google.com/uc?export=view&id=1TO7ucgL_lg_ipfW8KUniRzevlRU3vd5F';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      setState(() => _chapters = parsedJson['chapters'] );
    }
    else {
      throw Exception('Failed to load chapter data');
    }
    return 'Data fetched by _readJson()';
    // json loaded from internally from asset bundle
    // final String response = await rootBundle.loadString('assets/json/chapters.json');
    // final data = await json.decode(response);
    // setState( () => _chapters = data['chapters'] );
  }

  @override
  void initState() {
    super.initState();
    _download = _readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 38,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 26,
        itemBuilder: (context, index) {
          return ListTile(title: Text('testing list'));
        }
      ),
    );
  }
}
