import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/drawers.dart' as drawer;


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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10,),
            Stack(
              // first element starts at the bottom of stack
              children: <Widget>[
                Container(color: theme.primaryClr.withAlpha(0), height: 260, width: double.infinity,),
                Container(color: theme.redOfficial, height: 180, width: double.infinity,),
                Positioned(
                  bottom: 40.0,
                  left: 0.0,
                  child: Container(
                    height: 136, width: 110,
                    decoration: const BoxDecoration(
                      color: theme.offWhiteClr2,
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
                        const TextSpan(text: '2025-2026 '),
                        const TextSpan(text: 'Academic Year'),
                      ]
                    ),
                  )
                )
              ],
            ),
            const SizedBox( height: 2,),
            Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0),
              child: SizedBox(
                height: 340,
                width: double.infinity,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  color: Get.isDarkMode ? theme.bodyClr : theme.primaryClr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/img/bg/status.bg.webp'),
                      ListTile(
                        title: const Text('Chapter Status Tracker'),
                        subtitle: Text('Review chapter compliance progress and status', style: theme.TextThemes.size11(context),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: OverflowBar(
                          alignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(foregroundColor: theme.redOfficial),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<Widget>(
                                    builder: (BuildContext context) {
                                      return const ChapterComplianceScreen();
                                    }
                                  )
                                );
                              },
                              child: Text('LOG IN', style: theme.TextThemes.size20(context),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox( height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0),
              child: SizedBox(
                height: 340,
                width: double.infinity,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  color: Get.isDarkMode ? theme.bodyClr : theme.primaryClr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/img/bg/compliance.bg.jpg'),
                      ListTile(
                        title: const Text('Chapters Start Here'),
                        subtitle: Text('Log in here to managed your chapter compliance', style: theme.TextThemes.size11(context),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: OverflowBar(
                          alignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(foregroundColor: theme.redOfficial),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<Widget>(
                                    builder: (BuildContext context) {
                                      return const ChapterComplianceScreen();
                                    }
                                  )
                                );
                              },
                              child: Text('LOG IN', style: theme.TextThemes.size20(context),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox( height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0),
              child: SizedBox(
                height: 340,
                width: double.infinity,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  color: Get.isDarkMode ? theme.bodyClr : theme.primaryClr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('assets/img/bg/directors.bg.jpg'),
                      ListTile(
                        title: const Text('Directors Start Here'),
                        subtitle: Text('Log in here to managed chapter compliance', style: theme.TextThemes.size11(context),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: OverflowBar(
                          alignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(foregroundColor: theme.redOfficial),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<Widget>(
                                    builder: (BuildContext context) {
                                      return const DirectorScreen();
                                    }
                                  )
                                );
                              },
                              child: Text('LOG IN', style: theme.TextThemes.size20(context),),
                            ),
                            // FilledButton(
                            //   style:TextButton.styleFrom(
                            //     backgroundColor: theme.redOfficial,
                            //     shape: const RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.all(Radius.circular(4.0))
                            //     )
                            //   ),
                            //   onPressed: (){},
                            //   child: Text('LOG IN')
                            // ),
                            // SizedBox(width: 4,),
                            // OutlinedButton(
                            //   style:TextButton.styleFrom(
                            //     // backgroundColor: theme.redOfficial,
                            //     shape: const RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.all(Radius.circular(4.0))
                            //     )
                            //   ),
                            //   onPressed: (){},
                            //   child: Text('LOG IN', style: theme.TextThemes.colorDark(context),)
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox( height: 40,),
          ],
        ),
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon:  Get.isDarkMode ? const Icon(Icons.logout) : const Icon(Icons.logout),
          ),
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      drawer: const drawer.DrawerChapterCompliance(),
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon:  Get.isDarkMode ? const Icon(Icons.logout) : const Icon(Icons.logout),
          ),
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      drawer: const drawer.DrawerDirectorCompliance(),
    );
  }
}