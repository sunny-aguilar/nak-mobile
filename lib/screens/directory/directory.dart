import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/screens/directory/chart.dart' as chart;
import 'package:nak_app/screens/directory/directory_model.dart' as db;
import 'package:nak_app/screens/directory/chapter_list.dart' as bros;


class Directory extends StatefulWidget {
  const Directory({super.key});
  @override
  State<Directory> createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory> {
  void _handleThemeChange() => setState((){});
  late int chapterCount = 0;
  late int broCount = 0;
  late List<double> graphData = List<double>.generate(28, (i) => i.toDouble());

  void initializeDirectory() async {
    db.Directory().getDirectoryData().then((val) {
      setState((){
        chapterCount = val.chapterCount;
        broCount = val.broCount;
        graphData = val.graphData;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDirectory();
  }

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

      body: DirectoryDashboard(
        onChange: _handleThemeChange,
        chapterCount: chapterCount,
        broCount:broCount,
        graphData: graphData,
        initializeDirectory: initializeDirectory,
      ),
    );
  }
}


class DirectoryDashboard extends StatefulWidget {
  const DirectoryDashboard({
    super.key, required this.onChange, required this.chapterCount,
    required this.broCount, required this.graphData, required this.initializeDirectory,
  });
  final Function onChange;
  final int chapterCount;
  final int broCount;
  final List<double> graphData;
  final Function initializeDirectory;
  @override
  State<DirectoryDashboard> createState() => _DirectoryDashboardState();
}

class _DirectoryDashboardState extends State<DirectoryDashboard> {
  Future<void> _handleRefresh() async {
    widget.initializeDirectory();
    setState((){});
  }

  void _showInfoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Brother Directory', style: theme.TextThemes.headlineSmall20(context)),
          content: const Text('This screen lets users view brothers listed by chapter. Use the "View Brothers" card to browse names and the "Add a Brother" card to add or edit entries in the directory.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss', style: TextStyle(color: Color(0xFFC41230))),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      backgroundColor: theme.bronzeOfficial,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text(
                'Brother Directory',
                style: theme.TextThemes.gabaritoSize40(context),
              ),
              const SizedBox(height: 12,),
              const SizedBox(height: 12,),
              // Info card explaining purpose of this screen
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  color: Get.isDarkMode ? theme.darkGreyClr : theme.offWhiteClr,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    leading: Icon(Icons.info_outline, color: theme.redOfficial),
                    title: Text('Directory Info', style: theme.TextThemes.bodyLargeBold(context)),
                    subtitle: Text('View brothers by chapter, or add/edit brother entries.', style: theme.TextThemes.bodyLarge(context)),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new, color: theme.redOfficial),
                      onPressed: () => _showInfoDialog(context),
                    ),
                  ),
                ),
              ),
              // Row for graph *********************
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: 170,
                    width: MediaQuery.sizeOf(context).width,
                    child: Card(
                      color: Get.isDarkMode ? theme.uiRedClr : theme.uiGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: chart.MyBarGraph(chapterBrothers: widget.graphData,),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 12,
                    child: Text('Brothers at each chapter', style: TextStyle(color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr),)
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              // Row for brother metrics *********************
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Card(
                      color: Get.isDarkMode ? theme.greyUI : theme.uiGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.broCount.toString(), style: theme.TextThemes.size36(context).copyWith(fontWeight: FontWeight.bold),),
                          Text('Total Brothers')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Card(
                      color: Get.isDarkMode ? theme.greyUI : theme.uiGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.chapterCount.toString(), style: theme.TextThemes.size36(context).copyWith(fontWeight: FontWeight.bold),),
                          Text('Total Chapters')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              // Row for viewing/adding brothers *********************
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 220,
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(builder: (BuildContext context) {
                            return bros.ChapterListScreen(editBro: false,);
                          })
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Get.isDarkMode ? theme.greyUI : theme.primaryClr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Image.asset('assets/img/bg/directory_bg.webp'),
                            Container(height: 86, color: theme.uiRedClr,),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                              child: Text('View Brothers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Text('Find brothers listed by chapter.', style: theme.TextThemes.size11(context),),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    width: MediaQuery.sizeOf(context).width * .45,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(builder: (BuildContext context) {
                            return bros.ChapterListScreen(/*viewData: widget.viewData,*/ editBro: true,);
                          })
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Get.isDarkMode ? theme.greyUI : theme.primaryClr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Image.asset('assets/img/bg/directory_bg.webp'),
                            Container(height: 86, color: theme.uiRedClr,),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                              child: Text('Add a Brother', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Text('Don\'t see a name? Add or edit the bro in the directory.', style: theme.TextThemes.size11(context),),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(child: Icon(Icons.arrow_circle_down, size: 17,)),
                      TextSpan(
                        text:' refresh directory',
                        style: theme.TextThemes.collegeText(context).copyWith(color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr)
                      ),
                    ]
                  ),
                ),
              ),
              Container(height: 140,)
            ],
          ),
        ),
      ),
    );
  }
}




class NavDirectory extends StatefulWidget {
  const NavDirectory({super.key});
  @override
  State<NavDirectory> createState() => _NavDirectoryState();
}

class _NavDirectoryState extends State<NavDirectory> {
  void _handleThemeChange() => setState((){});
  late int chapterCount = 0;
  late int broCount = 0;
  late List<double> graphData = List<double>.generate(28, (i) => i.toDouble());

  void initializeDirectory() async {
    db.Directory().getDirectoryData().then((val) {
      chapterCount = val.chapterCount;
      broCount = val.broCount;
      graphData = val.graphData;
      setState((){});
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: NavDirectoryDashboard(
        onChange: _handleThemeChange,
        chapterCount: chapterCount,
        broCount:broCount,
        graphData: graphData,
        reload: initializeDirectory,
      ),
    );
  }
}


class NavDirectoryDashboard extends StatefulWidget {
  const NavDirectoryDashboard({
    super.key, required this.onChange, required this.chapterCount,
    required this.broCount, required this.graphData, required this.reload,
  });
  final Function onChange;
  final int chapterCount;
  final int broCount;
  final List<double> graphData;
  final Function reload;
  @override
  State<NavDirectoryDashboard> createState() => _NavDirectoryDashboard();
}

class _NavDirectoryDashboard extends State<NavDirectoryDashboard> {
  Future<void> _handleRefresh() async {
    widget.reload();
    setState((){});
  }

  void _showInfoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Brother Directory', style: theme.TextThemes.headlineSmall20(context)),
          content: const Text('This screen lets users view brothers listed by chapter. Use the "View Brothers" card to browse names and the "Add a Brother" card to add or edit entries in the directory.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Dismiss', style: TextStyle(color: Color(0xFFC41230))),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      backgroundColor: theme.bronzeOfficial,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text(
                'Brother Directory',
                style: theme.TextThemes.gabaritoSize40(context),
              ),
              const SizedBox(height: 12,),
              const SizedBox(height: 12,),
              // Info card explaining purpose of this screen
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  color: Get.isDarkMode ? theme.darkGreyClr : theme.offWhiteClr,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    leading: Icon(Icons.info_outline, color: theme.redOfficial),
                    title: Text('Directory Info', style: theme.TextThemes.bodyLargeBold(context)),
                    subtitle: Text('View brothers by chapter, or add/edit brother entries.', style: theme.TextThemes.bodyLarge(context)),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new, color: theme.redOfficial),
                      onPressed: () => _showInfoDialog(context),
                    ),
                  ),
                ),
              ),
              // Row for graph *********************
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: 170,
                    width: MediaQuery.sizeOf(context).width,
                    child: Card(
                      color: Get.isDarkMode ? theme.uiRedClr : theme.uiGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: chart.MyBarGraph(chapterBrothers: widget.graphData,),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 12,
                    child: Text('Brothers at each chapter', style: TextStyle(color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr),)
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              // Row for brother metrics *********************
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Card(
                      color: Get.isDarkMode ? theme.greyUI : theme.uiGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.broCount.toString(), style: theme.TextThemes.size36(context).copyWith(fontWeight: FontWeight.bold),),
                          Text('Total Brothers')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Card(
                      color: Get.isDarkMode ? theme.greyUI : theme.uiGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.chapterCount.toString(), style: theme.TextThemes.size36(context).copyWith(fontWeight: FontWeight.bold),),
                          Text('Total Chapters')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              // Row for viewing/adding brothers *********************
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 220,
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(builder: (BuildContext context) {
                            return bros.ChapterListScreen(editBro: false,);
                          })
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Get.isDarkMode ? theme.greyUI : theme.primaryClr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Image.asset('assets/img/bg/directory_bg.webp'),
                            Container(height: 86, color: theme.uiRedClr,),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                              child: Text('View Brothers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Text('Find brothers listed by chapter.', style: theme.TextThemes.size11(context),),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    width: MediaQuery.sizeOf(context).width * .45,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(builder: (BuildContext context) {
                            return bros.ChapterListScreen(/*viewData: widget.viewData,*/ editBro: true,);
                          })
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Get.isDarkMode ? theme.greyUI : theme.primaryClr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Image.asset('assets/img/bg/directory_bg.webp'),
                            Container(height: 86, color: theme.uiRedClr,),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                              child: Text('Add a Brother', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Text('Don\'t see a name? Add or edit the bro in the directory.', style: theme.TextThemes.size11(context),),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(child: Icon(Icons.arrow_circle_down, size: 17,)),
                      TextSpan(
                        text:' refresh directory',
                        style: theme.TextThemes.collegeText(context).copyWith(color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr)
                      ),
                    ]
                  ),
                ),
              ),
              Container(height: 140,)
            ],
          ),
        ),
      ),
    );
  }
}
