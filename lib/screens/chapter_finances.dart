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

  final String cfs = 'Charters are renewed on a yearly basis and being in good financial standing is a requirement. This list provides the current financial standing of each chapter.';
  final String cdt = 'The tracker shows the dues assessed each year and the payments received applied towards those dues. You must have an @nakinc.org email address to access the document.';
  final String cdr = 'The chapter dues report comes out monthly to reflect the total dues owed by each chapter.';
  final String cdg = 'The chapter dues guide provide yearly guidance on the dues assessed by Nu Alpha Kappa including payment plans available and due dates.';
  final String fg = 'This fundraising guide is meant to provide chapters a background on fundraising including ideas on the types of fundraisers.';
  final String fr = 'Fundraising forms and EIN requirements';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 12, bottom: 20),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Financial Resources',
                style: theme.TextThemes.headlineSmall20(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6,),
              Text(
                'Access chapter financial information and guidance',
                style: TextStyle(
                  color: theme.charcoalClr,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        cards.ChapterFinancesCard(
          title: 'Chapter Financial Status',
          cardIcon: Icons.monitor_heart_outlined,
          screen: ()=> const StatusScreen(),
          desc: 'Charter renewal progress',
          modalText: cfs,),
        cards.ChapterFinancesCard(
          title: 'Chapter Dues Tracker',
          cardIcon: Icons.trending_up,
          screen: ()=> const TrackerScreen(),
          desc: 'View charges and payments',
          modalText: cdt,),
        cards.ChapterFinancesCard(
          title: 'Chapter Dues Report',
          cardIcon: Icons.leaderboard,
          screen: ()=> const DuesReportScreen(),
          desc: 'View chapter dues monthly statement',
          modalText: cdr,),
        cards.ChapterFinancesCard(
          title: 'Chapter Dues Guide',
          cardIcon: Icons.route_outlined,
          screen: ()=> const DuesGuideScreen(),
          desc: 'Dues guidance for the year',
          modalText: cdg,),
        cards.ChapterFinancesCard(
          title: 'Fundraising Guide',
          cardIcon: FontAwesomeIcons.handHoldingDollar,
          screen: ()=> const FundraisingGuideScreen(),
          desc: 'A guide for chapter fundraising',
          modalText: fg,),
        cards.ChapterFinancesCard(
          title: 'Form Requirements',
          cardIcon: FontAwesomeIcons.file,
          screen: ()=> const FormsRequirementsScreen(),
          desc: 'EIN and forms required for fundraising',
          modalText: fr),
        const SizedBox(height: 12,),
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
  // final Future _chapterStatus = db_chapters.ChapterStatus().getFinancialStatus(); // dont do this! doesn't update

  Future<void> _handleRefresh() async { setState((){}); }

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 75, width: 75,
        child: CircularProgressIndicator(
          strokeWidth: 10, color: theme.redClr, backgroundColor: theme.lightGrey,
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder(
          future: Future.wait([
            _isSuperAdmin,
            db_chapters.ChapterStatus().getFinancialStatus(),
          ]),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error with request.'),);
              }
              else if (snapshot.hasData) {

                // check if user is superAdmin
                final bool isAdmin = snapshot.data![0];

                // check list count
                final int count = snapshot.data![1].length;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  itemCount: count,
                  itemBuilder: (context, index) {
                    // compile chapter data
                    Map<String, dynamic> chapterData = {};
                    // chapterData['chapter'] = snapshot.data![1][index].data()['chapter'];
                    // chapterData['char'] = snapshot.data![1][index].data()['char'];
                    // chapterData['financialApproval'] = snapshot.data![1][index].data()['financialApproval'];
                    // chapterData['id'] = snapshot.data![1][index].data()['id'];

                    // Map<String, dynamic> chapterData = {};
                    chapterData = snapshot.data![1][index].data();
                    // print('dat: ${chapterData}');

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: theme.shawdowClr.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Card(
                        elevation: 0,
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: isAdmin ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<Widget>(
                                builder: (BuildContext context) {
                                  return FinancialStatusScreen(chapter: chapterData);
                                }
                              )
                            );
                          } : null,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: chapterData['financialApproval'] ? theme.mintClr.withOpacity(0.2) : theme.warningClr.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${chapterData['char']}',
                                      style: theme.TextThemes.headlineMed(context),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            chapterData['financialApproval'] ? Icons.verified : Icons.report_problem_sharp,
                                            color: chapterData['financialApproval'] ? theme.mintClr : theme.warningClr,
                                            size: iconSize
                                          ),
                                          const SizedBox(width: 8,),
                                          Expanded(
                                            child: Text(
                                              '${chapterData['chapter']}',
                                              style: theme.TextThemes.headlineSmall16(context),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Text(
                                        chapterData['financialApproval'] ? 'Approved' : 'Not Approved',
                                        style: TextStyle(
                                          color: chapterData['financialApproval'] ? theme.mintClr : theme.warningClr,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isAdmin)
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: theme.greyClr,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                );
              }
            }
            return _circularProgress();
          },
        ),
      )
    );
  }
}


class FinancialStatusScreen extends StatefulWidget {
  const FinancialStatusScreen({super.key, required this.chapter});
  final Map<String, dynamic> chapter;
  @override
  State<FinancialStatusScreen> createState() => _FinancialStatusScreenState();
}

class _FinancialStatusScreenState extends State<FinancialStatusScreen> {
  bool enabledFinances = true;

  @override
  void initState() {
    super.initState();
    enabledFinances = widget.chapter['financialApproval'];
  }

  final WidgetStateProperty<Icon?> thumbIcon = WidgetStateProperty.resolveWith<Icon> (
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.chapter['chapter']} Status', style: theme.TextThemes.headlineMed(context),),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: theme.shawdowClr.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Financial Approval Status',
                      style: theme.TextThemes.headlineSmall20(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Approval Status:',
                              style: theme.TextThemes.bodyLarge(context),
                            ),
                            const SizedBox(height: 6,),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: enabledFinances ? theme.mintClr.withOpacity(0.2) : theme.warningClr.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                enabledFinances ? 'Approved' : 'Not Approved',
                                style: TextStyle(
                                  color: enabledFinances ? theme.mintClr : theme.warningClr,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          thumbIcon: thumbIcon,
                          value: enabledFinances,
                          activeColor: theme.mintClr,
                          onChanged: (bool val) {
                            setState(() {
                              enabledFinances = val;
                            });

                            // approve ore revoke financial approval
                            if (val) {
                              db_chapters.ChapterStatus().approveFinances(widget.chapter['id']);
                            }
                            else if (!val) {
                              db_chapters.ChapterStatus().revokeFinances(widget.chapter['id']);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 60, width: 60,
            child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
          ),
          const SizedBox(height: 16,),
          Text(
            'Loading...',
            style: theme.TextThemes.bodyLarge(Get.context!),
          ),
        ],
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
            Future<void> launchInWebView({required String url}) async {
              final Uri urlParsed = Uri.parse(url);
              if (!await launchUrl(urlParsed, mode: LaunchMode.inAppWebView)) {
                throw Exception('Could not launch $url');
              }
            }
            launchInWebView(url: httpsLink);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.trending_up, size: 80, color: theme.redOfficial.withOpacity(0.3),),
                  const SizedBox(height: 16,),
                  Text('Opening Tracker...', style: theme.TextThemes.bodyLarge(context),),
                ],
              ),
            );
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 60, width: 60,
            child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
          ),
          const SizedBox(height: 16,),
          Text(
            'Loading...',
            style: theme.TextThemes.bodyLarge(Get.context!),
          ),
        ],
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.wifi_off, size: 80, color: theme.charcoalClr.withOpacity(0.3),),
                    const SizedBox(height: 16,),
                    Text('No Internet Connection!', style: theme.TextThemes.headlineSmall20(context),),
                    const SizedBox(height: 8,),
                    Text('Please check your connection and try again', style: theme.TextThemes.bodyLarge(context),),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 60, width: 60,
            child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
          ),
          const SizedBox(height: 16,),
          Text(
            'Loading...',
            style: theme.TextThemes.bodyLarge(Get.context!),
          ),
        ],
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.wifi_off, size: 80, color: theme.charcoalClr.withOpacity(0.3),),
                    const SizedBox(height: 16,),
                    Text('No Internet Connection!', style: theme.TextThemes.headlineSmall20(context),),
                    const SizedBox(height: 8,),
                    Text('Please check your connection and try again', style: theme.TextThemes.bodyLarge(context),),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 60, width: 60,
            child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
          ),
          const SizedBox(height: 16,),
          Text(
            'Loading...',
            style: theme.TextThemes.bodyLarge(Get.context!),
          ),
        ],
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.wifi_off, size: 80, color: theme.charcoalClr.withOpacity(0.3),),
                    const SizedBox(height: 16,),
                    Text('No Internet Connection!', style: theme.TextThemes.headlineSmall20(context),),
                    const SizedBox(height: 8,),
                    Text('Please check your connection and try again', style: theme.TextThemes.bodyLarge(context),),
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


class FormsRequirementsScreen extends StatelessWidget {
  const FormsRequirementsScreen({super.key});

  final String einUrl = 'https://www.irs.gov/businesses/small-businesses-self-employed/get-an-employer-identification-number';
  final String w9Url = 'https://www.irs.gov/forms-pubs/about-form-w-9';
  final String w9Example = 'https://drive.google.com/file/d/1bqj24pJfrTaFoyTmixLfcrCTN-AHotgr/view?usp=sharing';

  final String prep = 'Fundraising begins with making sure your chapter has the right forms and chapter EIN ready to go.';
  final String einInfo = 'A chapter needs their own EIN. An EIN is like a social security number for your chapter. It is used to identify your chapter as a business entity. You can apply for an EIN through the IRS website. The EIN is needed to open a bank account and for fundraising.';
  final String formInfo = 'Business will often request for chapters to complete a W-9 form. This form is used to provide the business with your chapter\'s EIN and other information. The business will use this information to report any payments made to your chapter to the IRS.';
  final String einReq = 'An EIN can be obtained through the IRS website. The EIN is needed to open a bank account and for fundraising.\n You will need to provide the following information:';
  final String einInfoNeeded = '\n- Officer Name\n- Chapter Address\n- Officer Phone Number\n- Officer Email Address\n- Officer SSN';
  final String einLink = 'Once you are ready to apply for an EIN, you can do so through the IRS website. The link is below:';
  final String formW9Info = 'An entity that requests a W-9 form is usually a business that will be making payments to your chapter. You can obtain form W-9 from the IRS website. The link is below:';
  final String formW9Example = 'To complete the W-9 form, you will need to provide the chapter EIN information that was used to request the EIN. The link below provides you an example of a completed W-9 form. You can use this example to help you complete your own W-9 form (you must verify that the form is completed accurately since the National Organization is not responsible for the chapter\'s records).';

  void showLink(String url) {
    Future<void> launchInWebView({required String url}) async {
      final Uri urlParsed = Uri.parse(url);
      if (!await launchUrl(urlParsed, mode: LaunchMode.inAppWebView)) {
        throw Exception('Could not launch $url');
      }
    }
    launchInWebView(url: url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Form Requirements', style: theme.TextThemes.headlineMed(context),),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Fundraising Prep Section
              _buildSectionHeader(context, 'Fundraising Prep'),
              const SizedBox(height: 12,),
              _buildSectionContent(context, prep),
              const SizedBox(height: 28,),

              // EIN Section
              _buildSectionHeader(context, 'What is an EIN?'),
              const SizedBox(height: 12,),
              _buildSectionContent(context, einInfo),
              const SizedBox(height: 28,),

              // Forms Section
              _buildSectionHeader(context, 'W-9 Forms'),
              const SizedBox(height: 12,),
              _buildSectionContent(context, formInfo),
              const SizedBox(height: 28,),

              // How to Get EIN Section
              _buildSectionHeader(context, 'How to Get an EIN'),
              const SizedBox(height: 12,),
              _buildSectionContent(context, einReq),
              _buildSectionContent(context, einInfoNeeded, isHighlighted: true),
              const SizedBox(height: 12,),
              _buildSectionContent(context, einLink),
              const SizedBox(height: 16,),
              _buildLinkTile(
                context,
                'Get an EIN Online',
                Icons.open_in_new,
                () => showLink(einUrl),
              ),
              const SizedBox(height: 28,),

              // Forms Examples Section
              _buildSectionHeader(context, 'Form Examples'),
              const SizedBox(height: 12,),
              _buildSectionContent(context, formW9Info),
              const SizedBox(height: 16,),
              _buildLinkTile(
                context,
                'Download Form W-9',
                Icons.download,
                () => showLink(w9Url),
              ),
              const SizedBox(height: 24,),
              _buildSectionContent(context, formW9Example),
              const SizedBox(height: 16,),
              _buildLinkTile(
                context,
                'View Example Form W-9',
                Icons.description,
                () => showLink(w9Example),
              ),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: theme.TextThemes.headlineSmall20(context).copyWith(
        fontWeight: FontWeight.bold,
        color: theme.redOfficial,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content, {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlighted ? theme.redOfficial.withOpacity(0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isHighlighted
          ? Border.all(color: theme.redOfficial.withOpacity(0.2))
          : null,
      ),
      child: Text(
        content,
        style: theme.TextThemes.bodyLarge(context).copyWith(
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildLinkTile(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.redOfficial.withOpacity(0.3)),
            color: theme.redOfficial.withOpacity(0.05),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: theme.TextThemes.bodyLargeBold(context).copyWith(
                    color: theme.redOfficial,
                  ),
                ),
              ),
              Icon(icon, color: theme.redOfficial, size: 20,),
            ],
          ),
        ),
      ),
    );
  }
}