import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  File? _image;

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
        child: FutureBuilder(
          future: db.UserService().getData(),
          initialData: 'Initial data',
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    color: theme.redClr
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'An ${snapshot.error} occurred'
                  ),
                );
              }
              else if(snapshot.hasData) {
                final data = snapshot.data;
                return buildIDCard(data);
              }
            }
            return const Center(
              child: SizedBox(
                height: 150,
                  width: 150,
                child: CircularProgressIndicator(
                  color: theme.azureClr,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ID Widget
  ListView buildIDCard(data) {
    return ListView(
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
                  '${data['chapter']} Chapter'.toUpperCase(),
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

        // User Data Container
        Container(
          height: 300,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? theme.charcoalClr : theme.redOfficial,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),),
          ),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Container(
                  color: Get.isDarkMode ? theme.charcoalClr : theme.redOfficial,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${data['firstName']} ${data['lastName']}', style: theme.TextThemes.idUserName(context),),
                      const Spacer(),
                      Text('Line Number', style: theme.TextThemes.idLabel(context),),
                      Text('${data['lineNumber']}', style: theme.TextThemes.idBody(context),),
                      const Spacer(),
                      Text('Line Number', style: theme.TextThemes.idLabel(context),),
                      Text('${data['lineNumber']}', style: theme.TextThemes.idBody(context),),
                      const Spacer(),
                      Text('ID Number', style: theme.TextThemes.idLabel(context),),
                      Text('${data['nakID']}', style: theme.TextThemes.idBody(context),),
                      const Spacer(),
                      Text('Email', style: theme.TextThemes.idLabel(context),),
                      Text(data['email'], style: theme.TextThemes.idBody(context),),
                    ],
                  ),
                )
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  color: Get.isDarkMode ? theme.charcoalClr : theme.redOfficial,
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/img/users/profile.webp'),
                      Container(
                        width: 150,
                        height: 48,
                        color: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                        child: Center(
                          child: Text(
                            _image != null ? data['status'] : 'Add Image',
                            style: theme.TextThemes.idImageTitle(context),
                          )
                        )
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 100,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? theme.shawdowClr : theme.pinkClr,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FilledButton(
                onPressed: () {},
                child: const Text('Update Profile'),
              ),
              const SizedBox( width: 20,),
              FilledButton(
                onPressed: () {},
                child: const Text('Upload Photo'),
              ),
            ],
          ),
        ),


      ],
    );
  }
}