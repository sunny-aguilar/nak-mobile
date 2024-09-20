import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
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


class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});
  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  // check if there is an active internet connection
  final String url = 'https://drive.google.com/uc?export=view&id=1GVdr32DZ_NMGc6n8nad0GWgMzWqWevFd';

  Future<bool> checkInternet() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) { return false; }
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

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {});
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder(
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
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.wifi_off, size: 150,),
                      Text('No Internet Connection!')
                    ],
                  ),
                );
              }
            }
            else if (snapshot.connectionState == ConnectionState.waiting) { return _circularProgress(); }
            return _circularProgress();
          },
        ),
      )
      // body: const PDF(
      //   enableSwipe: true,
      //   swipeHorizontal: false,
      //   autoSpacing: true,
      //   pageFling: false,
      // ).fromUrl(url)
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