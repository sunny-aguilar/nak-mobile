import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/screens/directory/directory_model.dart' as db;
import 'package:nak_app/screens/directory/view_bros.dart' as view_bros;
import 'package:nak_app/screens/directory/edit_bro.dart' as edit_bro;
import 'package:nak_app/screens/directory/add_bro.dart' as add_bro;


class EditBroListScreen extends StatefulWidget {
  const EditBroListScreen({
    super.key, required this.broList,
    required this.chapterNum,
    required this.chapterID,
    required this.chapter,
    required this.editBro
  });
  final broList;
  final String chapterNum;
  final String chapterID;
  final String chapter;
  final bool editBro;
  @override
  State<EditBroListScreen> createState() => _BroListScreenState();
}

class _BroListScreenState extends State<EditBroListScreen> {
  Map viewData = {};

  List<String> lineNumbers(index) {
    List numberList = [];
    List<String> stringList = [];
    viewData[index.toString()].bros.forEach((key, val) {
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
        // title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        title: Text('${widget.chapter} chapter', style: theme.TextThemes.collegeText(context)),
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
          itemCount: viewData[widget.chapterNum].bros.length + 1 + 1,
          itemBuilder: (context, index) {

            // Provides a map of the bros of the specified chapter (chapterNum)
            Map<String, dynamic> broList = viewData[widget.chapterNum].bros;

            if (index == 0) {
              print('* * * * * * * * * * * * * * * * *');
              print('Index == 0: $index');
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 10, right: 16,),
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

            // Add button after bro list
            if (index > broList.length) {
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                        child: Text('Add a bro'),
                        onPressed: () {
                          // go to form screen to add bro
                          Navigator.push(
                            context,
                            MaterialPageRoute<Widget>(
                              builder: (BuildContext context) {
                                return add_bro.AddBro(chapterID: widget.chapterID);
                              }
                            )
                          );
                        },
                      ),
                  ],
                ),
              );
            }

            index -= 1;

            List<String> broNumber = lineNumbers(widget.chapterNum);
            // print('BroNumber: $broNumber');
            String name = broList[broNumber[index]]['name'];
            // print('Name: $name');
            String lineNumber = broList[broNumber[index]]['lineNumber'].toString();
            // print('lineNumber: $lineNumber');
            String chapClass = broList[broNumber[index]]['className'];
            // print('chapClass: $chapClass');
            chapClass = chapClass[0].toUpperCase() + chapClass.substring(1);

            Map<String, dynamic> bro = broList[broNumber[index]];
            // print('Bro: $bro');

            // Bro list
            return ListTile(
              onTap: () {
                /* GO TO VIEW OR EDIT SCREEN */
                if (widget.editBro) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) => edit_bro.EditBro(
                        broLineNumber: lineNumber,
                        broData: bro,
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


class ViewBroListScreen extends StatefulWidget {
  const ViewBroListScreen({
    super.key, required this.broList,
    required this.chapterNum,
    required this.chapterID,
    required this.chapter,
    required this.editBro
  });
  final broList;
  final String chapterNum;
  final String chapterID;
  final String chapter;
  final bool editBro;
  @override
  State<ViewBroListScreen> createState() => _ViewBroListScreen();
}

class _ViewBroListScreen extends State<ViewBroListScreen> {
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
        // title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        title: Text('${widget.chapter} chapter', style: theme.TextThemes.collegeText(context)),
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
          itemCount: viewData[widget.chapterNum].bros.length,
          itemBuilder: (context, index) {

            // Provides a map of the bros of the specified chapter (chapterNum)
            Map<String, dynamic> broList = viewData[widget.chapterNum].bros;

            List<String> broNumber = lineNumbers(widget.chapterNum);

            String name = broList[broNumber[index]]['name'];

            String lineNumber = broList[broNumber[index]]['lineNumber'].toString();

            String chapClass = broList[broNumber[index]]['className'];

            chapClass = chapClass[0].toUpperCase() + chapClass.substring(1);

            Map<String, dynamic> bro = broList[broNumber[index]];

            // Bro list
            return ListTile(
              onTap: () {
                /* GO TO VIEW OR EDIT SCREEN */
                if (widget.editBro) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) => edit_bro.EditBro(
                        broLineNumber: lineNumber,
                        broData: bro,
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