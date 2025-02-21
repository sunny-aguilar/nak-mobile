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
                      TextSpan(text: '2024-2025 '),
                      TextSpan(text: 'Academic Year'),
                    ]
                  ),
                )
              )
            ],
          ),
          const Text('Compliance Task', textAlign: TextAlign.center,),
          const Text('Chapters', textAlign: TextAlign.center,),
          const Text('Intake Directors', textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}