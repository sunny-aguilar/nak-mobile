import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/screens/directory/directory_model.dart' as db;
import 'package:nak_app/screens/directory/bro_lists.dart' as bro_list;


class ChapterListScreen extends StatefulWidget {
  const ChapterListScreen({super.key, required this.editBro});
  final bool editBro;
  @override
  State<ChapterListScreen> createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  late Map viewData = {};

  String chapterName(int index) {
    String chapter = viewData[index.toString()].chapterName;
    chapter = chapter[0].toUpperCase() + chapter.substring(1);
    return chapter;
  }

  String greekLetter(int index) {
    String greekLetter = viewData[index.toString()].greek;
    return greekLetter;
  }

  void intializeViewBroData() async {
    db.Directory().broData().then((val) {
      viewData = val;
      setState((){});
    });
  }

  @override
  void initState() {
    super.initState();
    intializeViewBroData();
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
        itemCount: viewData.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {

              if (widget.editBro){
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) => bro_list.EditBroListScreen(
                    broList: viewData[index.toString()],
                    chapterNum: viewData[index.toString()].chapNum,
                    chapterID: viewData[index.toString()].chapterID,
                    chapter: chapterName(index),
                    editBro: widget.editBro,
                  ))
                );
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) => bro_list.ViewBroListScreen(
                    broList: viewData[index.toString()],
                    chapterNum: viewData[index.toString()].chapNum,
                    chapterID: viewData[index.toString()].chapterID,
                    chapter: chapterName(index),
                    editBro: widget.editBro,
                  ))
                );
              }
            },
            leading: CircleAvatar(
              backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
              child: Text(greekLetter(index)),
            ),
            title: Text('${chapterName(index)} Chapter'),
            subtitle: Text('${viewData[index.toString()].broCount.toString()} Brothers Listed'),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}