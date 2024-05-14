import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nak_app/components/cards.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class NationalBoard extends StatefulWidget {
  const NationalBoard({super.key});
  @override
  State<NationalBoard> createState() => _NationalBoardState();
}

class _NationalBoardState extends State<NationalBoard> {
  List _board = [];
  int _count = 0;

  late Future<String> _download;

  Future<String> _readJson() async {
    String url = 'https://drive.google.com/uc?export=view&id=1r5B70c-bj4DDRYXB-WF4SsDzwtHXEB3q';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final parsedJson = jsonDecode(response.body);
      setState( () => _board = parsedJson['board'] );
    }
    else {
      throw Exception('Failed to load NEB members.');
    }
    _count = _board.length;
    return 'Data downloaded';
  }

  @override
  void initState() {
    super.initState();
    _download = _readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _download,
        builder: (context, snapshot) {

          // views when data is fetched but two outcomes possible
          if (snapshot.connectionState == ConnectionState.done) {

            // view if error fetching data
            if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
                  backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
                ),
                body: Center(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
                  ),
                ),
              );
            }
            // view if data is fetched and no errors occurred
            else if (snapshot.hasData) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    centerTitle: true,
                    title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
                    backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
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
                  BoardGridList(count: _count, board: _board),
                ],
              );
            }
          }

          // waiting screen
          return Scaffold(
            appBar: AppBar(
              title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
              backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
            ),
            body: Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(color: Get.isDarkMode ? theme.primaryClr : theme.redClr,)
              ),
            ),
          );
        },
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
        mainAxisExtent: 292.0,
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