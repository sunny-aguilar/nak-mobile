import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../components/cards.dart';

class NationalBoard extends StatefulWidget {
  const NationalBoard({super.key});
  @override
  State<NationalBoard> createState() => _NationalBoardState();
}

class _NationalBoardState extends State<NationalBoard> {
  List _board = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString("assets/json/board_members.json");
    final data = await json.decode(response);
    setState( () => _board = data["board"] );
  }
  @override
  void initState() {
    super.initState();
    readJson();
  }
  @override
  Widget build(BuildContext context) {
    int count = _board.length;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Image.asset("assets/img/nak_letters_bw.png", height: 30.0,),
            backgroundColor: const Color.fromARGB(255, 254, 58, 67),
            pinned: true,
            floating: true,
            snap: true,
            stretch: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.blurBackground,
              ],
              background: Image.asset(
                "assets/img/board_letters.png",
                fit: BoxFit.contain,
                height: 100,
              ),
            ),
          ),
          // SliverList
          // BoardCardList(items: (items), board: board)
          // SliverGrid <<<<<< ad here
          BoardGridList(count: count, board: _board),
        ],
      )
    );
  }
}

class BoardGridList extends StatelessWidget {
  final int count;
  final List board;
  const BoardGridList({super.key, required this.count, required this.board});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 1.0,
        mainAxisExtent: 276.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, index) {
          // return card here!
          return boardCard(context: context, index: index, board: board);
        },
        childCount: count,
      ),
    );
  }
}