import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/components/resource_cards.dart';
import 'package:nak_app/components/text_layouts.dart' as text_layouts;
import 'package:nak_app/ui/theme.dart' as theme;

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});
  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  final ScrollController _scrollController = ScrollController();
  void scrollUp() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final resource = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final String lettersImg = resource.lettersImg;
    final Map policyTxt = resource.policyTxt;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,  // ADD SCROLLING CONTROLLER HERE
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
            backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
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
          ResourceCardList(policyTxt: policyTxt, scrollUp: scrollUp,),
        ],
      ),
    );
  }
}

class ResourceCardList extends StatelessWidget {
  final Map policyTxt;
  final Function scrollUp;
  const ResourceCardList({super.key, required this.policyTxt, required this.scrollUp});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index){
          return text_layouts.textLayout(context: context, policyTxt: policyTxt, scrollUp: scrollUp);
        },
        childCount: 1,
      ),
    );
  }
}