import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../components/resource_cards.dart';
import '../../components/text.dart';

class ResourcesScreen extends StatelessWidget {
  ResourcesScreen({super.key});

  final List<String> imageList = [
    'assets/img/resource_thumbnails/drug_tn.png',
    'assets/img/resource_thumbnails/antihazing_thumbnail.webp',
    'assets/img/resource_thumbnails/retaliation_tn.png',
    'assets/img/resource_thumbnails/crisismgmt_tn.png',
    'assets/img/resource_thumbnails/ethics_tn.png',
    'assets/img/resource_thumbnails/samaritan_tn.png',
    'assets/img/resource_thumbnails/risk_tn.png',
    'assets/img/resource_thumbnails/misconduct_tn.png',
    'assets/img/resource_thumbnails/mentalhealth_tn.png',
    'assets/img/resource_thumbnails/prevention_tn.png',
    'assets/img/resource_thumbnails/titlex_tn.png',
  ];

  final List<String> titleList = [
    'Alcohol & Drug Policy',
    'Anti-Hazing Policy',
    'Anti-Retaliation',
    'Crisis Mgmt Plan',
    'Ethical Values',
    'Good Samaritan Policy',
    'Risk Management',
    'Sexual Misconduct',
    'Mental Health',
    'Sexual Assault Prevention',
    'Campux Title IX',
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
    '/mentalhealth',
    '/prevention',
    '/titleix',
  ];

  final List<String> lettersImg = [
    'assets/img/title_thumbnails/drugs_letters.webp',
    'assets/img/title_thumbnails/antihazing_letters.webp',
    'assets/img/title_thumbnails/antiretaliation_letters.webp',
    'assets/img/title_thumbnails/crisis_letters.webp',
    'assets/img/title_thumbnails/ethics_letters.webp',
    'assets/img/title_thumbnails/samaritan_letters.webp',
    'assets/img/title_thumbnails/risk_letters.webp',
    'assets/img/title_thumbnails/sexmisc_letters.webp',
    'assets/img/title_thumbnails/mentalhealth_letters.webp',
    'assets/img/title_thumbnails/prevention_letters.webp',
    'assets/img/title_thumbnails/titleix_letters.webp',
  ];

  @override
  Widget build(BuildContext context) {
    int crossAxisCounter = MediaQuery.of(context).size.width ~/ 180;
    // print('CrossAxis Size: $crossAxisCounter');
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
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
            return MasonryGridTile(
              image: imageList[index],
              title: titleList[index],
              route: resourceRoute[index],
              lettersImg: lettersImg[index],
              policyTxt: policyTxt[index], // make a list with objects
            );
          },
        ),
      ),
    );
  }
}
