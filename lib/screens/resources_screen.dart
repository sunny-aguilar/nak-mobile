import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../components/cards.dart';

class ResourcesScreen extends StatelessWidget {
  ResourcesScreen({super.key});

  final List<String> titleList = [
    'Conduct',
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
    'assets/img/square_240.png',
    'assets/img/square_340v4.png',
    'assets/img/square_240v2.png',
    'assets/img/square_240v3.png',
    'assets/img/square_240v5.png',
    'assets/img/square_240v8.png',
    'assets/img/square_340v2.png',
    'assets/img/square_340v3.png',
    'assets/img/square_240v4.png',
    'assets/img/square_240v6.png',
    'assets/img/square_340.png',
    'assets/img/square_240v7.png',
  ];

  @override
  Widget build(BuildContext context) {
    int crossAxisCounter = MediaQuery.of(context).size.width ~/ 180;
    print('CrossAxis Size: $crossAxisCounter');
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
            return MasonryGridTileV2(image: imageList[index], title: titleList[index]);
          },
        ),
      ),
    );
  }
}
