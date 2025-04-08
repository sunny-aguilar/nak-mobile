import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;


class ViewBro extends StatelessWidget {
  const ViewBro({super.key, required this.broData, required this.chapterID});
  final Map<String, dynamic> broData;
  final String chapterID;

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
      body: BroProfile(broData: broData,),
    );
  }
}


class BroProfile extends StatelessWidget {
  const BroProfile({super.key, required this.broData});
  final Map<String, dynamic> broData;

  // capitalize a string
  String _capitalize(String text) {
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  @override
  Widget build(BuildContext context) {

    String chapterClass = '${broData['className']} class';
    String chapterNumber = 'line #${broData['lineNumber']}';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment(1, 1),
            children: <Widget>[
              Align(
                child: Container(height: 260,),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 200,
                  // width: 350,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: theme.greyUI,
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                  ),
                  child: IntrinsicWidth(child: Container()),
                ),
              ),
              Align(
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: theme.primaryClr,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: theme.redClr,
                    foregroundColor: theme.primaryClr,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: theme.greyUI,
                            child: Icon(Icons.camera_alt, color: theme.primaryClr,),
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
          Text(_capitalize(chapterClass)),
          Text(chapterNumber),
          SizedBox(height: 20,),
          Text('Last modified by: '),
        ],
      ),
    );
  }
}