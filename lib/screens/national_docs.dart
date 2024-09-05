import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

class DocsScreen extends StatelessWidget {
  const DocsScreen({super.key});
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) {
                    return const ConstitutionScreen();
                  }
                ),
              );
            },
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) {
                    return const BylawsScreen();
                  }
                ),
              );
            },
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

class ConstitutionScreen extends StatelessWidget {
  const ConstitutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Constitution', style: theme.TextThemes.headlineMed(context),),
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
      body: const PDFViewer(pdfPath: 'assets/docs/constitution.pdf',),
    );
  }
}


class BylawsScreen extends StatelessWidget {
  const BylawsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bylaws', style: theme.TextThemes.headlineMed(context),),
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
      body: const PDFViewer(pdfPath: 'assets/docs/bylaws.pdf')
    );
  }
}


class PDFViewer extends StatelessWidget {
  const PDFViewer({super.key, required this.pdfPath});
  final String pdfPath;

  @override
  Widget build(BuildContext context) {
    return PDF(
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: true,
      pageFling: false,
      onError: (error) {
        print('Error: ${error.toString}');
      }
    ).fromAsset(pdfPath);
  }
}