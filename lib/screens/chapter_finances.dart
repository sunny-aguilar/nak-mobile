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
      children: <Widget>[
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

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                        child: Text('${chapterData['char']}', style: theme.TextThemes.headlineMed(context),), // store greek letter in db and pull into here?
                      ),
                      title: Row(
                        children: <Widget>[
                          Icon(
                            chapterData['financialApproval'] ? Icons.verified : Icons.report_problem_sharp,
                            color: chapterData['financialApproval'] ? theme.mintClr : theme.warningClr,
                            size: iconSize
                          ),
                          Text(' ${chapterData['chapter']} - ${chapterData['financialApproval'] ? 'approved' : 'not approved'}', style: theme.TextThemes.headlineSmall16(context))
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      enabled: isAdmin,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                            builder: (BuildContext context) {
                              return FinancialStatusScreen(chapter: chapterData);
                            }
                          )
                        );
                      },
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
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Financial Approval:'),
              trailing: Switch(
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
            ),
          ],
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
            Future<void> launchInWebView({required String url}) async {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10,),
              Text('Fundraising Prep', style: theme.TextThemes.headlineMed(context),),
              const SizedBox(height: 6,),
              Text(prep, style: theme.TextThemes.bodyLarge(context),),
              const SizedBox(height: 20,),
              Text('EIN', style: theme.TextThemes.bodyLargeBold(context),),
              const SizedBox(height: 6,),
              Text(einInfo, style: theme.TextThemes.bodyLarge(context),),
              const SizedBox(height: 20,),
              Text('Forms', style: theme.TextThemes.bodyLargeBold(context),),
              const SizedBox(height: 6,),
              Text(formInfo, style: theme.TextThemes.bodyLarge(context),),
              const SizedBox(height: 20,),
              Text('EIN - How to get one', style: theme.TextThemes.headlineMed(context),),
              const SizedBox(height: 6,),
              Text(einReq, style: theme.TextThemes.bodyLarge(context),),
              Text(einInfoNeeded, style: theme.TextThemes.bodyLarge(context),),
              const SizedBox(height: 6,),
              Text(einLink, style: theme.TextThemes.bodyLarge(context),),
              ListTile(
                title: Text('Get an EIN Online', style:  theme.TextThemes.colorBlue(context).copyWith(fontFamily: 'College', fontSize: 18),),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => showLink(einUrl),
              ),
              const SizedBox(height: 20,),
              Text('Forms - Examples', style: theme.TextThemes.headlineMed(context),),
              const SizedBox(height: 6,),
              Text(formW9Info, style: theme.TextThemes.bodyLarge(context),),
              ListTile(
                title: Text('Download Form W-9', style:  theme.TextThemes.colorBlue(context).copyWith(fontFamily: 'College', fontSize: 18),),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => showLink(w9Url),
              ),
              const SizedBox(height: 20,),
              Text(formW9Example, style: theme.TextThemes.bodyLarge(context),),
              ListTile(
                title: Text('View Example Form W-9', style:  theme.TextThemes.colorBlue(context).copyWith(fontFamily: 'College', fontSize: 18),),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => showLink(w9Example),
              ),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}