import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;


class ComplianceScreen extends StatelessWidget {
  const ComplianceScreen({super.key});
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10,),
          Stack(
            // first element starts at the bottom of stack
            children: <Widget>[
              Container(color: theme.primaryClr.withAlpha(0), height: 280, width: double.infinity,),
              Container(color: theme.redOfficial, height: 180, width: double.infinity,),
              Positioned(
                bottom: 60.0,
                left: 0.0,
                child: Container(
                  height: 136, width: 110,
                  decoration: const BoxDecoration(
                    color: theme.bronzeOfficial,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(18.0), bottomRight: Radius.circular(18.0))
                  ),
                )
              ),
              Positioned(
                top: 100.0,
                left: 140.0,
                // child: Text('Chapter Compliance', style: theme.TextThemes.headlineSmall20(context).copyWith(color: theme.primaryClr),)
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Chapter Compliance\n', style: theme.TextThemes.headlineSmall20(context)),
                      const TextSpan(text: '2024-2025 '),
                      const TextSpan(text: 'Academic Year'),
                    ]
                  ),
                )
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text('Compliance Task', style: theme.TextThemes.oswaldText(context).copyWith(fontSize: 24.0),),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 30.0, top: 10.0, right: 24.0),
              // shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.assessment), title: const Text('FOR CHAPTERS'),
                  tileColor: theme.chatGregyClr,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) {
                          return const ChapterComplianceScreen();
                        }
                      )
                    );
                  },
                ),
                const SizedBox(height: 5.0,),
                ListTile(
                  leading: const Icon(Icons.assessment), title: const Text('FOR COMPLIANCE VP'),
                  tileColor: theme.chatGregyClr,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) {
                          return const DirectorScreen();
                        }
                      )
                    );
                  },
                ),
                Container(
                  // container used to give card a height
                  height: 200,
                  child: const Card(
                    color: theme.primaryClr,
                    elevation: 5.0, // shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      side: BorderSide(color: theme.greyClr, width: 4.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Chapters Start Here'),
                    ),
                  ),
                ),
                Container(
                  // container used to give card a height
                  height: 200,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Directors Start Here'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ChapterComplianceScreen extends StatelessWidget {
  const ChapterComplianceScreen({super.key});

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
    );
  }
}



class DirectorScreen extends StatelessWidget {
  const DirectorScreen({super.key});

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
    );
  }
}