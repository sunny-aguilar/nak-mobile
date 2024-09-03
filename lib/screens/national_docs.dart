import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

class DocsScreen extends StatefulWidget {
  const DocsScreen({super.key});

  @override
  State<DocsScreen> createState() => _DocsScreenState();
}

class _DocsScreenState extends State<DocsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 30,
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
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: () {print('I was tapped');},
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: theme.primaryClr,
                border: Border(
                  top: BorderSide(width: 1, color: theme.dividerClr),
                  bottom: BorderSide(width: 1, color: theme.dividerClr),
                ),
              ),
              child: const Center(child: Text('National Constitution'),),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: theme.primaryClr,
                border: Border(
                  bottom: BorderSide(width: 1, color: theme.dividerClr),
                ),
              ),
              child: const Center(child: Text('National Bylaws'),),
            ),
          ),
        ],
      ),
    );
  }
}