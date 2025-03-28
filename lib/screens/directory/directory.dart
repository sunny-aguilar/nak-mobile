import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/screens/directory/chart.dart' as chart;


class Directory extends StatefulWidget {
  const Directory({super.key});

  @override
  State<Directory> createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory> {
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
      body: const DirectoryDashboard(),
    );
  }
}


class DirectoryDashboard extends StatefulWidget {
  const DirectoryDashboard({super.key});
  @override
  State<DirectoryDashboard> createState() => _DirectoryDashboardState();
}

class _DirectoryDashboardState extends State<DirectoryDashboard> {
  List<double> chapterBrothers = [
    100,120,90,150,110,70,
    50,110,130,140,120,80,
    90,60,100,130,70,60,
    110,120,90,150,80,130,
    60,100,120,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Text('Brother\nDirectory', style: theme.TextThemes.gabaritoText(context).copyWith(fontSize: 40, fontWeight: FontWeight.w900),),
          Container(
            height: 170,
            width: double.infinity,
            child: Center(
              child: chart.MyBarGraph(chapterBrothers: chapterBrothers,),
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 220,
                width: 200,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  color: Get.isDarkMode ? theme.bodyClr : theme.primaryClr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/img/nak_letters.png'),
                      ListTile(
                        title: const Text('View Brothers'),
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
              Text('View Brothers'),
              Text('Add Brother'),
            ],
          ),
        ],
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
