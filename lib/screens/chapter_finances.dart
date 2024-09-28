import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/db/db_chapters.dart' as db_chapters;
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
          title: 'Chapter Financial Status',
          cardIcon: Icons.monitor_heart_outlined,
          screen: ()=> const StatusScreen(),
          desc: 'Charter renewal progress'),
        cards.ChapterFinancesCard(
          title: 'Chapter Dues Tracker',
          cardIcon: Icons.trending_up,
          screen: ()=> const TrackerScreen(),
          desc: 'View charges and payments'),
        cards.ChapterFinancesCard(
          title: 'Chapter Dues Report',
          cardIcon: Icons.leaderboard,
          screen: ()=> const DuesReportScreen(),
          desc: 'View chapter dues monthly statement'),
        cards.ChapterFinancesCard(
          title: 'Chapter Dues Guide',
          cardIcon: Icons.route_outlined,
          screen: ()=> const DuesGuideScreen(),
          desc: 'Dues guidance for the year'),
        cards.ChapterFinancesCard(
          title: 'Fundraising Guide',
          cardIcon: FontAwesomeIcons.handHoldingDollar,
          screen: ()=> const FundraisingGuideScreen(),
          desc: 'A guide for chapter fundraising'),
      ],
    );
  }
}


class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});
  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final double iconSize = 30;

  final Future<bool> _isSuperAdmin = db.AuthCheck().isSuperAdmin('superAdmin');
  final Future _chapterStatus = db_chapters.ChapterStatus().getFinancialStatus();

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 75, width: 75,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.lightGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Financial Status', style: theme.TextThemes.headlineMed(context),),
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
        future: Future.wait([
          _isSuperAdmin,
          _chapterStatus,
        ]),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error returning future'),);
            }
            else if (snapshot.hasData) {

              // check if user is superAdmin
              final bool isAdmin = snapshot.data![0];
              // final String chapter = snapshot.data![1][0].id;
              final bool approval = snapshot.data![1][0].data()['financial.approval'];
              final int count = snapshot.data![1].length;

              // print('data[1][0].data(): ${snapshot.data![1][0].data()}');
              // print('data[1][0].data(): ${snapshot.data![1][0].data()['financial.approval']}');
              // print('data[1][0].data(): ${snapshot.data![1][0].id}');

              return ListView.builder(
                shrinkWrap: true,
                itemCount: count,
                itemBuilder: (context, index) {
                  // compile chapter data
                  Map<String, dynamic> chapterData = {};
                  chapterData['chapter'] = snapshot.data![1][index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('F'), // store greek letter in db and pull into here?
                    ),
                  );
                }
              );


              return ListView(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('F'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.report_problem_sharp, color: theme.warningClr, size: iconSize,),
                        Text(' Founding: ${approval ? 'approved' : 'Not approved'}')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // get chapter data
                      final String chapter = snapshot.data![1][0].data()['chapter'];
                      // go to route
                      Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) {
                            return FinancialStatusScreen(chapter: chapter);
                          }
                        )
                      );
                    },
                    enabled: isAdmin, //
                  ),

                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('A'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Alpha: Approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('B'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Beta: Approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('Γ'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Gamma: Approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('Δ'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Delta: Approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('E'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Epsilon: Approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('Z'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.report_problem_sharp, color: theme.warningClr, size: iconSize,),
                        const Text(' Zeta: Not approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('H'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.report_problem_sharp, color: theme.warningClr, size: iconSize,),
                        const Text(' Eta: Not approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('Θ'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Theta: Not approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('I'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Iota: Not approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('K'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Kappa: Not approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('Λ'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Lambda: Not approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('M'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Mu: Not approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () { print('tapped'); },
                    enabled: true,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                      child: const Text('N'),
                    ),
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.verified, color: theme.mintClr, size: iconSize,),
                        const Text(' Nu: Not approved')
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () { print('tapped'); },
                    enabled: false, // resolve to boolean to ennable/disable tap
                  ),
                ],
              );
            }
          }
          return const Center(child: Text('No data returned'),);
        },
      )
    );
  }
}


class FinancialStatusScreen extends StatefulWidget {
  const FinancialStatusScreen({super.key, required this.chapter});
  final String chapter;
  @override
  State<FinancialStatusScreen> createState() => _FinancialStatusScreenState();
}

class _FinancialStatusScreenState extends State<FinancialStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.chapter} Status', style: theme.TextThemes.headlineMed(context),),
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
            return const Center(child: Icon(Icons.trending_up, size: 150,));
          }
          else if (snapshot.connectionState == ConnectionState.waiting) { return _circularProgress(); }
          return _circularProgress();
        }
      )
    );
  }
}


class DuesReportScreen extends StatelessWidget {
  const DuesReportScreen({super.key});

  final String url = 'https://drive.google.com/uc?export=view&id=1uSORGn_oGy8K4I80dCXcC0msg5G8-xNc';

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


class DuesGuideScreen extends StatelessWidget {
  const DuesGuideScreen({super.key});

  final String url = 'https://drive.google.com/uc?export=view&id=1MmzEeFsQDlZjwSu32xpb3eUBnQmou4mv';

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


class FundraisingGuideScreen extends StatelessWidget {
  const FundraisingGuideScreen({super.key});

  final String url = 'https://drive.google.com/uc?export=view&id=1M1-AYrQQHrWtN_M7axjDO-3z1CFXlllq';
// https://drive.google.com/file/d/1M1-AYrQQHrWtN_M7axjDO-3z1CFXlllq/view?usp=sharing
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
        title: Text('Fundraising Guide', style: theme.TextThemes.headlineMed(context),),
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
      ),
    );
  }
}