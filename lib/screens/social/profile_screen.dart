import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_social.dart' as social_db;




class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  // edit fields
  Future<void> editField(String field) async {}

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 75, width: 75,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.lightGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Profile', style: theme.TextThemes.headlineMedLarge(context),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: social_db.SocialUsers().getUserData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {

            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 380,
                      padding: const EdgeInsets.only(top: 40),
                      decoration: const BoxDecoration(color: theme.redClr),
                      child: Image.asset('assets/img/nak_letters.png', alignment: Alignment.topCenter,),
                    ),
                    Container(
                      width: double.infinity,
                      height: 135,
                      decoration: BoxDecoration(color: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr),
                    ),
                    CircleAvatar(
                      backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                      radius: MediaQuery.sizeOf(context).width * .33,
                      child: CircleAvatar(
                        backgroundColor: theme.redOfficial, radius: MediaQuery.sizeOf(context).width * .315,
                        backgroundImage: NetworkImage(userData['selfie']),
                        child: const Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: theme.lightGrey,
                                // child: Icon(Icons.photo_camera, color: theme.darkGreyClr, size: 32,),
                                child: Icon(CupertinoIcons.camera_fill, color: theme.darkGreyClr, size: 32,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18,),
                Text(
                  '${userData['firstName']} ${userData['lastName']}',
                  textAlign: TextAlign.center,
                  style: theme.TextThemes.fontCollegeNN(context, 34).copyWith(color: theme.zincClr),
                ),
                const SizedBox(height: 8,),
                const Divider( thickness: 2, color: theme.chatGreyClr,),
                const SizedBox(height: 8,),
                InfoTextBox(text: '${userData['firstName']} ${userData['lastName']}', sectionName: 'Name'),
                InfoTextBox(text: '${userData['firstName']} ${userData['lastName']}', sectionName: 'Major'),
                InfoTextBox(text: '${userData['firstName']} ${userData['lastName']}', sectionName: 'Workplace'),
              ],
            );
          }
          else if (snapshot.hasError) {
            return const Center(child: Text('Error displaying data'));
          }

          return _circularProgress();

        }
      )
    );
  }
}


class InfoTextBox extends StatelessWidget {
  const InfoTextBox({super.key, required this.text, required this.sectionName});
  final String text;
  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 15, right: 5, bottom: 15),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? theme.graphiteClr : theme.chatGreyClr,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName, style: theme.TextThemes.fontCollegeNN(context, 14).copyWith(color: theme.shawdowClr),),
              IconButton(onPressed: (){}, icon: const Icon(Icons.settings, color: theme.shawdowClr,))
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}