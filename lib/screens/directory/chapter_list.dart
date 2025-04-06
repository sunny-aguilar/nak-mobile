import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/screens/directory/directory_model.dart' as db;
import 'package:nak_app/screens/directory/view_bros.dart' as view_bros;
import 'package:nak_app/screens/directory/add_bro.dart' as add_bro;

class ChapterListScreen extends StatefulWidget {
  const ChapterListScreen({super.key, /*required this.viewData,*/ required this.editBro});
  // final Map viewData;
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

  Future<void> _handleRefresh() async {
    intializeViewBroData();
    setState(() {});
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView.builder(
          itemCount: viewData.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) => BroListScreen(
                    broList: viewData[index.toString()],
                    chapterNum: viewData[index.toString()].chapNum,
                    chapterID: viewData[index.toString()].chapterID,
                    editBro: widget.editBro,
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
      ),
    );
  }
}

// FIX STATE SO THAT NAMES UPDATE
class BroListScreen extends StatefulWidget {
  const BroListScreen({super.key, required this.broList, required this.chapterNum, required this.chapterID, required this.editBro});
  final broList;
  final String chapterNum;
  final String chapterID;
  final bool editBro;
  @override
  State<BroListScreen> createState() => _BroListScreenState();
}

class _BroListScreenState extends State<BroListScreen> {
  Map viewData = {};

  List<String> lineNumbers(index) {
    List numberList = [];
    List<String> stringList = [];
    viewData[index.toString()].bros.forEach((key, val) {
      // print('Key to add: $key - val: $val');
      numberList.add(int.parse(key));
    });
    numberList.sort();
    stringList = numberList.map((val) => val.toString()).toList();
    return stringList;
  }

  Future<void> _handleRefresh() async {
    intializeViewBroData();
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
      body: RefreshIndicator(
        backgroundColor: theme.redClr,
        onRefresh: _handleRefresh,
        child:
          viewData.isEmpty  // prevent list from showing up as null
          ? Center(child: Text('Loading...'),)
          : ListView.builder(
          itemCount: widget.broList.bros.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                      child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(child: Icon(Icons.arrow_circle_down, size: 17,)),
                              TextSpan(
                                text:' refresh list',
                                style: theme.TextThemes.collegeText(context).copyWith(color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr)
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // print('\n\nOG Index: $index');
            index -= 1;
            // print('Index: $index\n');
            // print('All Data******************\n: $viewData');
            // print('\n********\n');
            // print('Bros: ${viewData[widget.chapterNum].bros}');
            List<String> broNumber = lineNumbers(widget.chapterNum);
            // print('BroNumber: $broNumber');
            String name = viewData[widget.chapterNum].bros[broNumber[index]]['name'];
            // print('Name: $name');
            String lineNumber = viewData[widget.chapterNum].bros[broNumber[index]]['lineNumber'].toString();
            // print('lineNumber: $lineNumber');
            String chapClass = viewData[widget.chapterNum].bros[broNumber[index]]['className'];
            // print('chapClass: $chapClass');
            chapClass = chapClass[0].toUpperCase() + chapClass.substring(1);


            //TODO: add data to temporarily replace null viewData as widget initializes

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
        ),
      )
    );
  }
}