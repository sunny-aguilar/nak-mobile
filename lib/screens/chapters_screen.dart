import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nak_app/components/cards.dart' as card;
import 'package:nak_app/ui/theme.dart' as theme;


class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key});
  @override
  State<ChapterScreen> createState() => _ChapterScreensState();
}

class _ChapterScreensState extends State<ChapterScreen> {
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
  }

  @override
  void initState() {
    super.initState();
    _download = _readJson();
  }

  Center _circularProgress() {
    return Center(
      child: SizedBox(
        height: 60, width: 60,
        child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int chapterCount = _chapters.length;
    return Scaffold(
      body: FutureBuilder<String>(
        future: _download,
        builder: (context, snapshot) {

          // views when data is fetched but two outcomes possible
          if (snapshot.connectionState == ConnectionState.done) {

            // view if error fetching data
            if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
                  backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
                ),
                body: Center(
                  child: Column(
                    children: <Widget>[
                      const Icon(Icons.wifi, size: 150,),
                      Text(
                        'An error occurred fetching chapter data. \nError: ${snapshot.error} occurred.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            // view if data is fetched and no errors occurred
            else if (snapshot.hasData) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    centerTitle: true,
                    title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
                    backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
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
                        'assets/img/title_thumbnails/chapter_letters.png',
                        fit: BoxFit.contain,
                        height: 100,
                      ),
                    ),
                  ),
                  ChapterCardList(chapterCount: chapterCount, chapters: _chapters),
                ],
              );
            }

          }

          // view when data is being fetched
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
                backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
              ),
              body: _circularProgress(),
            );
          }

          // default screen if no data is returned
          return Scaffold(
            appBar: AppBar(
              title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
              backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
            ),
            body: _circularProgress(),
          );
        }

      ),
    );
  }
}

class ChapterCardList extends StatelessWidget {
  final int chapterCount;
  final List chapters;
  const ChapterCardList({super.key, required this.chapterCount, required this.chapters});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return card.chapterCard(context: context, index: index, chapters: chapters);
        },
        childCount: chapterCount,
      ),
    );
  }
}