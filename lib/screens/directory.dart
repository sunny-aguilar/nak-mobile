import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nak_app/services/theme_service.dart' as service;


class Directory extends StatelessWidget {
  const Directory({super.key});

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
      body: Center(child: Text('Directory Main Page'),)
    );
  }
}


class ChapterList extends StatefulWidget {
  const ChapterList({super.key});
  @override
  State<ChapterList> createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {
  List _chapters = [];
  late Future<String> _download;

  Future<String> _readJson() async{
    // json loaded externally from G drive, developer@nakinc.org
    String url = 'https://drive.google.com/uc?export=view&id=1TO7ucgL_lg_ipfW8KUniRzevlRU3vd5F';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      setState(() => _chapters = parsedJson['chapters'] );
    }
    else {
      throw Exception('Failed to load chapter data');
    }
    return 'Data fetched by _readJson()';
    // json loaded from internally from asset bundle
    // final String response = await rootBundle.loadString('assets/json/chapters.json');
    // final data = await json.decode(response);
    // setState( () => _chapters = data['chapters'] );
  }

  @override
  void initState() {
    super.initState();
    _download = _readJson();
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
      body: ListView.builder(
        itemCount: 26,
        itemBuilder: (context, index) {
          return ListTile(title: Text('testing list'));
        }
      ),
    );
  }
}
