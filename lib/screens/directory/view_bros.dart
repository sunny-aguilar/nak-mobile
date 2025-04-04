import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;

class ViewBrothersScreen extends StatelessWidget {
  const ViewBrothersScreen({super.key, required this.viewData});
  final Map viewData;

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
                MaterialPageRoute<Widget>(builder: (BuildContext context) => ChapterBros(broList: viewData[index.toString()]) )
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


class ChapterBros extends StatelessWidget {
  const ChapterBros({super.key, required this.broList});
  final broList;

  List<String> lineNumbers(index) {
    List numberList = [];
    List<String> stringList = [];

    broList.bros.forEach((key, val) {
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
        itemCount: broList.bros.length,
        itemBuilder: (context, index) {

          List<String> broNumber = lineNumbers(index);
          // print(broList.bros[broNumber[index]]);dw
          String name = broList.bros[broNumber[index]]['name'];
          String lineNumber = broList.bros[broNumber[index]]['lineNumber'].toString();
          String chapClass = broList.bros[broNumber[index]]['class'];
          chapClass = chapClass[0].toUpperCase() + chapClass.substring(1);

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(builder: (BuildContext context) => ViewBro(broData: broList.bros[broNumber[index]],) )
              );
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

class ViewBro extends StatelessWidget {
  const ViewBro({super.key, required this.broData});
  final Map<String, dynamic> broData;

  @override
  Widget build(BuildContext context) {
    print('Bro Data: $broData');

    String chapterClass = '${broData['class']} class';
    String chapterNumber = 'line #${broData['lineNumber']}';

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
      body: BroProfile(broData: broData,),
      // body: Padding(
      //   padding: const EdgeInsets.all(50.0),
      //   child: Column(
      //     children: <Widget>[
      //       Row(
      //         children: <Widget>[
      //           CircleAvatar(
      //             radius: 62,
      //             backgroundColor: theme.zincClr,
      //             child: CircleAvatar(
      //               radius: 54,
      //               backgroundColor: theme.uiRedClr,
      //               foregroundColor: theme.primaryClr,
      //               child: Stack(
      //                 children: <Widget>[
      //                   Align(
      //                     alignment: Alignment.bottomRight,
      //                     child: CircleAvatar(
      //                       radius: 18,
      //                       backgroundColor: theme.greyUI,
      //                       child: Icon(Icons.camera_alt),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //           const SizedBox(width: 10,),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Text(broData['name'], style: theme.TextThemes.gabaritoText(context).copyWith(fontSize: 30, fontWeight: FontWeight.bold),),
      //               Text(chapterClass),
      //               Text(chapterNumber),
      //             ],
      //           ),
      //         ],
      //       ),
      //       Text('Last edited by: name here'),
      //     ],
      //   ),
      // ),
    );
  }
}

class BroProfile extends StatelessWidget {
  const BroProfile({super.key, required this.broData});
  final Map<String, dynamic> broData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Align(
              // child: Container(height: 260,),
              child: Container(height: 260, color: theme.zincClr,),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: theme.redClr,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CircleAvatar(
                radius: 82,
                backgroundColor: theme.primaryClr,
                child: CircleAvatar(
                  radius: 74,
                  backgroundColor: theme.uiRedClr,
                  foregroundColor: theme.primaryClr,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: theme.greyUI,
                          child: Icon(Icons.camera_alt),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Text(broData['name'], style: theme.TextThemes.gabaritoText(context).copyWith(fontSize: 30, fontWeight: FontWeight.bold),),
        Text(broData['class']),
        Text(broData['lineNumber'].toString()),
      ],
    );
  }
}