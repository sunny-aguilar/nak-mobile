import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nak_app/components/resource_cards.dart';
import 'package:nak_app/components/text.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/resources_db.dart' as db;

/// Resources screen showing all the resources grid style
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int crossAxisCounter = MediaQuery.of(context).size.width ~/ 180;
    // print('CrossAxis Size: $crossAxisCounter');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.whiteClr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: MasonryGridView.count(
          crossAxisCount: crossAxisCounter,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: db.imageList.length,
          itemBuilder: (context, index) {
            return MasonryGridTile(
              image: db.imageList[index],
              title: db.titleList[index],
              route: db.resourceRoute[index],
              lettersImg: db.lettersImg[index],
              policyTxt: policyTxt[index], // make a list with objects
            );
          },
        ),
      ),
    );
  }
}
