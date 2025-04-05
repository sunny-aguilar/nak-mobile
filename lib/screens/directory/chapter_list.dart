import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/screens/directory/view_bros.dart' as view_bros;
import 'package:nak_app/screens/directory/add_bro.dart' as add_bro;

class ChapterListScreen extends StatelessWidget {
  const ChapterListScreen({super.key, required this.viewData, required this.editBro});
  final Map viewData;
  final bool editBro;

  String chapterName(int index) {
    String chapter = viewData[index.toString()].chapterName;
    chapter = chapter[0].toUpperCase() + chapter.substring(1);
    return chapter;
  }

  String greekLetter(int index) {
    String greekLetter = viewData[index.toString()].greek;
    return greekLetter;
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
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) => BroListScreen(
                  broList: viewData[index.toString()],
                  chapterID: viewData[index.toString()].chapterID,
                  editBro: editBro,
                ))
              );
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

// FIX STATE SO THAT NAMES UPDATE
class BroListScreen extends StatefulWidget {
  const BroListScreen({super.key, required this.broList, required this.chapterID, required this.editBro});
  final broList;
  final String chapterID;
  final bool editBro;

  @override
  State<BroListScreen> createState() => _BroListScreenState();
}

class _BroListScreenState extends State<BroListScreen> {
  List<String> lineNumbers(index) {
    List numberList = [];
    List<String> stringList = [];

    widget.broList.bros.forEach((key, val) {
      numberList.add(int.parse(key));
    });
    numberList.sort();

    stringList = numberList.map((val) => val.toString()).toList();

    return stringList;
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
        itemCount: widget.broList.bros.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListTile(
              tileColor: theme.greyClr,
              title: Text('Chapter Brothers', style: theme.TextThemes.collegeText(context).copyWith(fontSize: 22),),
            );
          }
          index -= 1;

          List<String> broNumber = lineNumbers(index);
          String name = widget.broList.bros[broNumber[index]]['name'];
          String lineNumber = widget.broList.bros[broNumber[index]]['lineNumber'].toString();
          String chapClass = widget.broList.bros[broNumber[index]]['className'];
          chapClass = chapClass[0].toUpperCase() + chapClass.substring(1);

          return ListTile(
            onTap: () {
              if (widget.editBro) {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext context) => add_bro.AddBro(
                      broData: widget.broList.bros[broNumber[index]],
                      chapterID: widget.chapterID,
                    )
                  )
                );
              }
              else{
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (BuildContext context) => view_bros.ViewBro(broData: widget.broList.bros[broNumber[index]], chapterID: widget.chapterID,)
                  )
                );
              }
            },
            title: Text(name, style: theme.TextThemes.collegeText(context).copyWith(fontSize: 22),),
            subtitle: Text('$chapClass class #$lineNumber'),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
      )
    );
  }
}