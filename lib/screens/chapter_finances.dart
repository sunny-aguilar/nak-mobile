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
        Card.outlined(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: 20,),
                  const Icon(Icons.trending_up, size: 50,),
                  const SizedBox(width: 50,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Chapter Dues Tracker', style: theme.TextThemes.drawerMenu(context),),
                      Text('second row of text'),
                      Text('third row of text'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40,),
              const Row(
                children: <Widget>[
                  const SizedBox(width: 20,),
                  Icon(Icons.thumb_up_outlined),
                  const SizedBox(width: 10,),
                  Text('Like'),
                  const SizedBox(width: 50,),
                  Icon(Icons.mode_comment_outlined),
                  const SizedBox(width: 10,),
                  Text('Comment'),
                ],
              ),
              const SizedBox(height: 15,),
            ],
          ),
        ),
        Container(
          height: 50,
          decoration: const BoxDecoration(
            color: theme.primaryClr,
          ),
          child: const Text('Chapter Dues Tracker'),
        ),
        Container(
          height: 50,
          decoration: const BoxDecoration(
            color: theme.azureClr,
          ),
          child: const Text('Chapter Dues Reports'),
        ),
      ],
    );
  }
}