import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:nak_app/components/radial_gauge.dart' as guage;
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
                height: 360,
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
                                      return const StatusComplianceScreen();
                                    }
                                  )
                                );
                              },
                              child: Text('CHECK STATUS', style: theme.TextThemes.size20(context),),
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
                height: 360,
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
                height: 360,
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


class StatusComplianceScreen extends StatelessWidget {
  const StatusComplianceScreen({super.key});

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
      body: const ChapterList(),
    );
  }
}

class ChapterList extends StatelessWidget {
  const ChapterList({super.key});
  final double spacer = 18.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: const guage.ComplianceGuage(progressValue: 100,),
            title: Text('Founding', style: theme.TextThemes.size20(context),),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) { return const TimelineScreen(); }
                )
              );
            },
          ),
          SizedBox(height: spacer,),
          ListTile(
            leading: const guage.ComplianceGuage(progressValue: 25,),
            title: Text('Alpha', style: theme.TextThemes.size20(context),),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) { return const TimelineScreen(); }
                )
              );
            },
          ),
          SizedBox(height: spacer,),
          ListTile(
            leading: const guage.ComplianceGuage(progressValue: 90,),
            title: Text('Beta', style: theme.TextThemes.size20(context),),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) { return const TimelineScreen(); }
                )
              );
            },
          ),
          SizedBox(height: spacer,),
          ListTile(
            leading: const guage.ComplianceGuage(progressValue: 50,),
            title: Text('Gamma', style: theme.TextThemes.size20(context),),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) { return const TimelineScreen(); }
                )
              );
            },
          ),
          SizedBox(height: spacer,),
          ListTile(
            leading: const guage.ComplianceGuage(progressValue: 100,),
            title: Text('Delta', style: theme.TextThemes.size20(context),),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) { return const TimelineScreen(); }
                )
              );
            },
          ),
          SizedBox(height: spacer,),
          ListTile(
            leading: const guage.ComplianceGuage(progressValue: 10,),
            title: Text('Epsilon', style: theme.TextThemes.size20(context),),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) { return const TimelineScreen(); }
                )
              );
            },
          ),
        ],
      ),
    );
  }
}

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: ListView(
          shrinkWrap: true,
          children: const <Widget>[
            ComplianceTimeline(isFirst: true, islast: false, isPast: true, eventCard: Text('Compliance Activity')),
            ComplianceTimeline(isFirst: false, islast: false, isPast: true, eventCard: Text('Compliance Activity')),
            ComplianceTimeline(isFirst: false, islast: false, isPast: false, eventCard: Text('Compliance Activity')),
            ComplianceTimeline(isFirst: false, islast: false, isPast: false, eventCard: Text('Compliance Activity')),
            ComplianceTimeline(isFirst: false, islast: false, isPast: false, eventCard: Text('Compliance Activity')),
            ComplianceTimeline(isFirst: false, islast: false, isPast: false, eventCard: Text('Compliance Activity')),
            ComplianceTimeline(isFirst: false, islast: true, isPast: false, eventCard: Text('Compliance Activity')),
          ],
        ),
      ),
    );
  }
}


class ComplianceTimeline extends StatelessWidget {
  const ComplianceTimeline({
    super.key,
    required this.isFirst,
    required this.islast,
    required this.isPast,
    required this.eventCard
  });
  final bool isFirst;
  final bool islast;
  final bool isPast;
  final eventCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: islast,
        // decorate the lines
        beforeLineStyle: LineStyle(color: isPast ? theme.redOfficial : theme.greyClr),
        // decorate the icon
        indicatorStyle: IndicatorStyle(
          width: 40.0,
          color: isPast ? theme.redOfficial : theme.greyClr,
          iconStyle: IconStyle(
            iconData: Icons.done,
            color: isPast ? theme.primaryClr : theme.greyClr
          )
        ),
        // event card
        endChild: EventCard(isPast: isPast, child: eventCard,),
      ),
    );
  }
}


class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.isPast, required this.child});
  final bool isPast;
  final child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: isPast ? theme.redOfficial : theme.greyClr,
        borderRadius: BorderRadius.circular(8)
      ),
      child: child,
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