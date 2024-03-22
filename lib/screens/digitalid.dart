import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;


class DigitalIDScreen extends StatefulWidget {
  const DigitalIDScreen({super.key});
  @override
  State<DigitalIDScreen> createState() => _DigitalIDScreenState();
}

class _DigitalIDScreenState extends State<DigitalIDScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 0.0, bottom: 0.0),
        child: FutureBuilder(
          future: db.UserService().getUsersFromFirebase(),
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
                return buildID(data);
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
  ListView buildID(data) {
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
                      // Text(db.makeUser()),
                      const Spacer(),
                      Text('Major', style: theme.TextThemes.idLabel(context),),
                      Text('Computer Science', style: theme.TextThemes.idBody(context),),
                      const Spacer(),
                      Text('ID Number', style: theme.TextThemes.idLabel(context),),
                      Text('1988 1996 0005 0033', style: theme.TextThemes.idBody(context),),
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
                      Image.asset(
                        'assets/img/users/profile.webp',
                        width: 150,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: 150,
                        height: 48,
                        color: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                        child: Center(
                          child: Text(
                            data['status'],
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

        // QR Code Container
        Container(
          height: 320,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? theme.shawdowClr : theme.pinkClr,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
          ),
          child: Center(
            child: Image.asset(
              'assets/img/id/qrcode.webp',
              height: 220,
            ),
          ),
        ),

      ],
    );
  }
}