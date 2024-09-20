import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/cards.dart' as cards;

class ChapterFinances extends StatelessWidget {
  const ChapterFinances({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chapter Finances', style: theme.TextThemes.headlineMed(context),),
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
      body: const FinanceBody(),
    );
  }
}


class FinanceBody extends StatelessWidget {
  const FinanceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        cards.ChapterFinancesCard(title: 'Chapter Dues Tracker', cardIcon: Icons.trending_up, screen: ()=> const TrackerScreen(),),
        cards.ChapterFinancesCard(title: 'Chapter Dues Report', cardIcon: Icons.leaderboard, screen: ()=> const ReportScreen(),),
        cards.ChapterFinancesCard(title: 'Chapter Dues Guide', cardIcon: Icons.route_outlined, screen: ()=> const GuideScreen(),),
        cards.ChapterFinancesCard(title: 'Chapter Dues Guide', cardIcon: FontAwesomeIcons.route, screen: ()=> const GuideScreen(),),
      ],
    );
  }
}


class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dues Tracker', style: theme.TextThemes.headlineMed(context),),
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
      body: Placeholder()
    );
  }
}


class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  // check if there is an active internet connection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dues Guide', style: theme.TextThemes.headlineMed(context),),
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
      body: Placeholder()
    );
  }
}


class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dues Report', style: theme.TextThemes.headlineMed(context),),
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
      body: Placeholder()
    );
  }
}