import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/screens/directory/directory_model.dart' as db;


class ViewBro extends StatelessWidget {
  const ViewBro({super.key, required this.broData, required this.chapterID});
  final Map<String, dynamic> broData;
  final String chapterID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 38,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      body: BroProfile(broData: broData,),
    );
  }
}


class BroProfile extends StatefulWidget {
  const BroProfile({super.key, required this.broData});
  final Map<String, dynamic> broData;
  @override
  State<BroProfile> createState() => _BroProfileState();
}

class _BroProfileState extends State<BroProfile> {
  late String userName = '';

  void getUserName() async {
    db.Directory().getUserData().then((val) {
      userName = '${val['firstName']} ${val['lastName']}';
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {

    // print('BroData: ${widget.broData}');
    String chapterClass = '${widget.broData['className']}';
    String chapterNumber = '${widget.broData['lineNumber']}';
    String modifiedDate = widget.broData['modifiedBy']['modifiedDate'];

    return ProfileWidget(
      broData: widget.broData,
      chapterClass: chapterClass,
      chapterNumber: chapterNumber,
      modifiedDate: modifiedDate,
      userName: userName,
    );

    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       Stack(
    //         alignment: Alignment(1, 1),
    //         children: <Widget>[
    //           Align(
    //             child: Container(height: 260,),
    //           ),
    //           Positioned(
    //             top: 0,
    //             left: 0,
    //             child: Container(
    //               height: 200,
    //               // width: 350,
    //               width: MediaQuery.sizeOf(context).width,
    //               decoration: BoxDecoration(
    //                 color: theme.greyUI,
    //               ),
    //               child: IntrinsicWidth(child: Container()),
    //             ),
    //           ),
    //           Align(
    //             child: CircleAvatar(
    //               radius: 90,
    //               backgroundColor: theme.primaryClr,
    //               child: CircleAvatar(
    //                 radius: 80,
    //                 backgroundColor: theme.redClr,
    //                 foregroundColor: theme.primaryClr,
    //                 child: Stack(
    //                   children: <Widget>[
    //                     Align(
    //                       alignment: Alignment.bottomRight,
    //                       child: CircleAvatar(
    //                         radius: 20,
    //                         backgroundColor: theme.greyUI,
    //                         child: Icon(Icons.camera_alt, color: theme.primaryClr,),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       SizedBox(height: 10,),
    //       Text(widget.broData['name'], style: theme.TextThemes.gabaritoText(context).copyWith(fontSize: 30, fontWeight: FontWeight.bold),),
    //       Text(_capitalize('$chapterClass class')),
    //       Text('line #$chapterNumber'),
    //       SizedBox(height: 200,),
    //       Text('Last modified by:', style: theme.TextThemes.collegeText(context),),
    //       Text(userName),
    //       SizedBox(height: 10,),
    //       Text('Modified Date:', style: theme.TextThemes.collegeText(context)),
    //       Text(modifiedDate),
    //     ],
    //   ),
    // );
  }
}


class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.broData,
    required this.chapterClass,
    required this.chapterNumber,
    required this.modifiedDate,
    required this.userName,
  });
  final Map broData;
  final String chapterClass;
  final String chapterNumber;
  final String modifiedDate;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.07,),
          Center(
            child: CircleAvatar(
              radius: 161,
              backgroundColor: Color.fromARGB(40, 254, 58, 67),
              child: CircleAvatar(
                radius: 160,
                backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                child: CircleAvatar(
                  radius: 135,
                  backgroundColor: Color.fromARGB(55, 254, 58, 67),
                  child: CircleAvatar(
                    radius: 133,
                    backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                    child: CircleAvatar(
                      radius: 108,
                      backgroundColor: Color.fromARGB(100, 254, 58, 67),
                      child: CircleAvatar(
                        radius: 105,
                        backgroundColor: Get.isDarkMode ? Color.fromARGB(255, 54, 45, 45) : Color.fromARGB(255, 255, 241, 247),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: theme.redClr,
                          foregroundColor: theme.primaryClr,
                          // child: Stack(
                          //   children: <Widget>[
                          //     Align(
                          //       alignment: Alignment.bottomRight,
                          //       child: CircleAvatar(
                          //         radius: 20,
                          //         backgroundColor: theme.greyUI,
                          //         child: Icon(Icons.camera_alt, color: theme.primaryClr,),
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
            Text(broData['name'], style: theme.TextThemes.gabaritoText(context).copyWith(fontSize: 30, fontWeight: FontWeight.bold),),
            Text('$chapterClass class'),
            Text('line #$chapterNumber'),
            SizedBox(height: 200,),
            Text('Last modified by:', style: theme.TextThemes.collegeText(context),),
            Text(userName),
            SizedBox(height: 10,),
            Text('Modified Date:', style: theme.TextThemes.collegeText(context)),
            Text(modifiedDate),
            SizedBox(height: 20,),
        ],
      ),
    );
  }
}