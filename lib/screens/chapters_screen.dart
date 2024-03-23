import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:nak_app/components/cards.dart';
import 'package:nak_app/ui/theme.dart' as theme;


class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key});
  @override
  State<ChapterScreen> createState() => _ChapterScreensState();
}

class _ChapterScreensState extends State<ChapterScreen> {
  List _chapters = [];
  Future<void> readJson() async{
    // can JSON file be loaded from an online source?
    final String response = await rootBundle.loadString('assets/json/chapters.json');
    final data = await json.decode(response);
    setState( () => _chapters = data['chapters'] );
  }
  @override
  void initState() {
    super.initState();
    readJson();
  }
  @override
  Widget build(BuildContext context) {
    int items = _chapters.length;
    return Scaffold(
      body: CustomScrollView(
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
          ChapterCardList(items: items, chapters: _chapters),
        ],
      ),
    );
  }
}

class ChapterCardList extends StatelessWidget {
  final int items;
  final List chapters;
  const ChapterCardList({super.key, required this.items, required this.chapters});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return chapterCard(context: context, index: index, chapters: chapters);
        },
        childCount: items,
      ),
    );
  }
}