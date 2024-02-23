import 'package:flutter/material.dart';
import '../../components/text_layouts.dart';

class AlcoholScreen extends StatelessWidget {
  const AlcoholScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Image.asset("assets/img/nak_letters_bw.png", height: 30.0,),
            backgroundColor: const Color.fromARGB(255, 254, 58, 67),
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
                "assets/img/title_thumbnails/drugs_letters.webp",
                fit: BoxFit.contain,
                height: 100,
              ),
            ),
          ),
          const ConductCardList(),
        ],
      ),
    );
  }
}

class ConductCardList extends StatelessWidget {
  const ConductCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index){
          return ConductText();
        },
        childCount: 1,
      ),
    );
  }
}