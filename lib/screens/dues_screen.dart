import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:nak_app/components/cards.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class DuesScreen extends StatefulWidget {
  const DuesScreen({super.key});
  @override
  State<DuesScreen> createState() => _DuesScreenState();
}

class _DuesScreenState extends State<DuesScreen> {
  List _dues = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/dues.json');
    final data = await json.decode(response);
    setState( () => _dues = data['dues'] );
  }
  @override
  void initState() {
    super.initState();
    readJson();
  }
  @override
  Widget build(BuildContext context) {
    int items = _dues.length;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
            backgroundColor: theme.redClr,
            pinned: true,
            floating: false,
            snap: false,
            stretch: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.blurBackground,
              ],
              background: Image.asset(
                'assets/img/title_thumbnails/dues_letters.png',
                fit: BoxFit.contain,
                height: 100,
              ),
            ),
          ),
          DuesCardList(items: items, dues: _dues),
        ],
      ),
    );
  }
}

class DuesCardList extends StatelessWidget {
  final int items;
  final List dues;
  const DuesCardList({super.key, required this.items, required this.dues});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return duesCard(context: context, index: index, dues: dues);
        },
        childCount: items,
      ),
    );
  }
}