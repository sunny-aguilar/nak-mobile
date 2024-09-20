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
      children: const <Widget>[
        cards.ChapterFinancesCard(title: 'Chapter Dues Tracker', cardIcon: Icons.trending_up,),
        cards.ChapterFinancesCard(title: 'Chapter Dues Report', cardIcon: Icons.leaderboard,),
        cards.ChapterFinancesCard(title: 'Chapter Dues Guide', cardIcon: Icons.route_outlined,),
        cards.ChapterFinancesCard(title: 'Chapter Dues Guide', cardIcon: FontAwesomeIcons.route,),
      ],
    );
  }
}