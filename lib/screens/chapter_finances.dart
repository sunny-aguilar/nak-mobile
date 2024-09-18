import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

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
        Container(
          child: Text('Text describing chapter finances.'),
        ),
        Card(
          child: Text('Card'),
        ),
        Container(
          height: 50,
          decoration: const BoxDecoration(
            color: theme.azureClr,
          ),
          child: Text('Chapter Dues Tracker'),
        ),
        Container(
          height: 50,
          decoration: const BoxDecoration(
            color: theme.azureClr,
          ),
          child: Text('Chapter Dues Reports'),
        ),
      ],
    );
  }
}