import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nak_app/components/cards.dart';

class NationalBoard extends StatefulWidget {
  const NationalBoard({super.key});
  @override
  State<NationalBoard> createState() => _NationalBoardState();
}

class _NationalBoardState extends State<NationalBoard> {
  List _board = [];
  Future<void> readJson() async {
    String url = 'https://drive.google.com/uc?export=view&id=1giKNa_tuQdJXJmyUUMMMOg_Fnurj1XLH';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      setState( () => _board = parsedJson );
    }
    else {
      throw Exception('Failed to load NEB members.');
    }

    // loading board members from local JSON file
    // final String response = await rootBundle.loadString('assets/json/board_members.json');
    // final data = await json.decode(response);
    // setState( () => _board = parsedJson );
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
            title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
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
                'assets/img/title_thumbnails/board_letters.png',
                fit: BoxFit.contain,
                height: 100,
              ),
            ),
          ),
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
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        mainAxisExtent: 276.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, index) {
          // return card here!
          // return boardCard(context: context, index: index, board: board);
          return boardCard(context: context, index: index, board: Boardmember.fromJson(board[index]));
        },
        childCount: count,
      ),
    );
  }
}

class Boardmember {
  Boardmember({required this.position, required this.name, required this.email, required this.image});
  final String position;
  final String name;
  final String email;
  final String image;

  factory Boardmember.fromJson(Map<String, dynamic> data) {
    final position = data['position'] as String;
    final name = data['name'] as String;
    final email = data['email'] as String;
    final image = data['image'] as String;
    return Boardmember(position: position, name: name, email: email, image: image);
  }
}