import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../components/cards.dart';

class ResourcesScreen extends StatelessWidget {
  ResourcesScreen({super.key});

  final List<String> titleList = [
    'Alcohol & Drug Policy',
    'Anti-Hazing Policy',
    'Crisis Mgmt Plan',
    'Ethical Values',
    'Good Samaritan Policy',
    'Risk Management',
    'Anti-Retaliation',
    'Sexual Misconduct',
    'Mental Health',
    'Sexual Assault Prevention',
    'Campux Title IX',
  ];

  final List<String> imageList = [
    'assets/img/resource_thumbnails/drug_tn.png',
    'assets/img/resource_thumbnails/antihazing_thumbnail.webp',
    'assets/img/resource_thumbnails/crisismgmt_tn.png',
    'assets/img/resource_thumbnails/ethics_tn.png',
    'assets/img/resource_thumbnails/samaritan_tn.png',
    'assets/img/resource_thumbnails/risk_tn.png',
    'assets/img/resource_thumbnails/retaliation_tn.png',
    'assets/img/resource_thumbnails/misconduct_tn.png',
    'assets/img/resource_thumbnails/mentalhealth_tn.png',
    'assets/img/resource_thumbnails/prevention_tn.png',
    'assets/img/resource_thumbnails/titlex_tn.png',
  ];

  final List<String> resourceRoute = [
    '/drugs',
    '/antihazing',
    '/antiretaliation',
    '/crisismgmt',
    '/ethics',
    '/samaritan',
    '/riskmgmt',
    '/sexualmisconduct',
    '/sexualmisconduct',
    '/sexualmisconduct',
    '/sexualmisconduct',
  ];

  @override
  Widget build(BuildContext context) {
    int crossAxisCounter = MediaQuery.of(context).size.width ~/ 180;
    // print('CrossAxis Size: $crossAxisCounter');
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/img/nak_letters_bw.png", height: 30.0,),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: MasonryGridView.count(
          crossAxisCount: crossAxisCounter,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: imageList.length,
          itemBuilder: (context, index) {
            return MasonryGridTileV2(image: imageList[index], title: titleList[index], route: resourceRoute[index]);
          },
        ),
      ),
    );
  }
}
