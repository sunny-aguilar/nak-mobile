import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});
  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 0.0, bottom: 0.0),
        child: ListView(
          children: <Widget>[

            // Chapter Identification Container
            const SizedBox(height: 20,),
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? theme.shawdowClr : theme.pinkClr,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Upload Your Photo',
                      style: theme.TextThemes.idTitle(context),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset('assets/img/nak_letters.png', width: 95,),
                  ),
                ],
              ),
            ),

            // User Photo Container
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? theme.charcoalClr : theme.redOfficial,
              ),
              child: Center(child: Text('Photo')),
            ),

            // bottom container with buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 100,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? theme.shawdowClr : theme.pinkClr,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FilledButton(onPressed: () {}, child: Text('Choose Picture'))
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}