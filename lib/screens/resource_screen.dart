import 'package:flutter/material.dart';
import 'package:nak_app/components/resource_cards.dart';
import '../components/text_layouts.dart';

class ResourceScreen extends StatelessWidget {
  const ResourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resource = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final String lettersImg = resource.lettersImg;
    final Map policyTxt = resource.policyTxt;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
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
                lettersImg,
                fit: BoxFit.contain,
                height: 100,
              ),
            ),
          ),
          ResourceCardList(policyTxt: policyTxt),
        ],
      ),
    );
  }
}

class ResourceCardList extends StatelessWidget {
  final Map policyTxt;
  const ResourceCardList({super.key, required this.policyTxt});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index){
          return textLayout(context: context, policyTxt: policyTxt);
        },
        childCount: 1,
      ),
    );
  }
}