import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
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
        cards.ChapterFinancesCard(
          title: 'Chapter Dues Tracker',
          cardIcon: Icons.trending_up,
          screen: ()=> const TrackerScreen(),
          desc: 'View charges and payments'),
        cards.ChapterFinancesCard(
          title: 'Chapter Dues Report',
          cardIcon: Icons.leaderboard,
          screen: ()=> const ReportScreen(),
          desc: 'View chapter dues monthly statement'),
        cards.ChapterFinancesCard(
          title: 'Chapter Dues Guide',
          cardIcon: FontAwesomeIcons.route,
          screen: ()=> const GuideScreen(),
          desc: 'Dues guidance for the year'),
      ],
    );
  }
}


class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  final String url = 'https://drive.google.com/uc?export=view&id=1kzmOzF5UXX4WX5fhUCRbg_juL5URGTJw';

  Future<bool> _checkInternet() async {
    // check if there is an active internet connection
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) { return true; }
    else { return false; }
  }

  Center _circularProgress() {
    return Center(
      child: SizedBox(
        height: 60, width: 60,
        child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
      ),
    );
  }

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
      body: FutureBuilder(
        future: _checkInternet(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
            // URL launcher
            const String httpsLink = 'https://docs.google.com/spreadsheets/d/11NPQHvmcKvtfFKW6bUhxoYde4KX2Sg1wynZNVLi_6ao/edit?usp=sharing';
;           Future<void> launchInWebView({required String url}) async {
              final Uri urlParsed = Uri.parse(url);
              if (!await launchUrl(urlParsed, mode: LaunchMode.inAppWebView)) {
                throw Exception('Could not launch $url');
              }
            }
            launchInWebView(url: httpsLink);
            return const Center(child: Icon(Icons.bar_chart, size: 150,));
          }
          else if (snapshot.connectionState == ConnectionState.waiting) { return _circularProgress(); }
          return _circularProgress();
        }
      )
    );
  }
}


class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  final String url = 'https://drive.google.com/uc?export=view&id=11PIxPV6x0PgqXLmddSSFIi3BvmbNzGQE';

  Future<bool> _checkInternet() async {
    // check if there is an active internet connection
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) { return true; }
    else { return false; }
  }

  Center _circularProgress() {
    return Center(
      child: SizedBox(
        height: 60, width: 60,
        child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
      ),
    );
  }

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
      body: FutureBuilder(
        future: _checkInternet(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
            // return PDF if URL link is working
            if (snapshot.data!) {
              return const PDF(
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: true,
                pageFling: false,
              ).fromUrl(url);
            }
            else {
              // return something else if URL link is not working
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.sizeOf(context).height/6),
                    const Icon(Icons.wifi_off, size: 150, color: theme.charcoalClr,),
                    const Text('No Internet Connection!'),
                  ],
                ),
              );
            }
          }
          else if (snapshot.connectionState == ConnectionState.waiting) { return _circularProgress(); }
          return _circularProgress();
        }
      )
    );
  }
}


class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  final String url = 'https://drive.google.com/uc?export=view&id=1GVdr32DZ_NMGc6n8nad0GWgMzWqWevFd';

  Future<bool> checkInternet() async {
    // check if there is an active internet connection
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) { return true; }
    else { return false; }
  }

  Center _circularProgress() {
    return Center(
      child: SizedBox(
        height: 60, width: 60,
        child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
      ),
    );
  }

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
      body: FutureBuilder(
        future: checkInternet(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // return PDF if URL link is working
            if (snapshot.data!) {
              return const PDF(
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: true,
                pageFling: false,
              ).fromUrl(url);
            }
            else {
              // return something else if URL link is not working
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.sizeOf(context).height/6),
                    const Icon(Icons.wifi_off, size: 150, color: theme.charcoalClr,),
                    const Text('No Internet Connection!'),
                  ],
                ),
              );
            }
          }
          else if (snapshot.connectionState == ConnectionState.waiting) { return _circularProgress(); }
          return _circularProgress();
        },
      )
    );
  }
}