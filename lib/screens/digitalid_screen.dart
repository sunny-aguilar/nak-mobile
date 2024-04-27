import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/components/qrcode.dart';
import 'package:http/http.dart' as http;
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${data['firstName']} ${data['lastName']}', style: theme.TextThemes.idUserName(context),),
                      Text('Line Number\n${data['lineNumber']}', style: theme.TextThemes.idBody(context),),
                      Text('ID Number\n${data['nakID']}', style: theme.TextThemes.idBody(context),),
                      Text('Email\n${data['email']}', style: theme.TextThemes.idBody(context),),
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
                      // data['selfie'] != null ?
                      //   Image.network(
                      //     data['selfie'],
                      //     fit: BoxFit.cover,
                      //     height: 200,
                      //   ) :
                      //   Image.asset('assets/img/users/profile.webp'),
                      FutureBuilder(
                        future: http.get(Uri.parse(data['selfie'])),
                        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return const  SizedBox(height: 120, child: Text('Loading Photo'),);
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return const SizedBox(
                                height: 150,
                                child: Center(
                                  child: SizedBox(
                                    height: 75,
                                    width: 75,
                                    child: CircularProgressIndicator(color: theme.primaryClr,),
                                  ),
                                ),
                              );
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Image.asset('assets/img/users/profile.webp');
                              }
                              return Image.memory(snapshot.data!.bodyBytes, fit: BoxFit.cover, height: 200,);
                          }
                        }
                      ),
                      Container(
                        width: 150,
                        height: 48,
                        color: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                        child: Center(
                          child: Text(
                            data['isNEB'] ? 'NEB' : data['status'],
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
            child: GenerateQRCode(
              firstName: '${data['firstName']}',
              lastName: '${data['lastName']}',
              chapter: '${data['chapter']}',
              lineNumber: '${data['lineNumber']}',
              status: '${data['status']}',
              nakID: '${data['nakID']}',
            ),
          ),
        ),

      ],
    );
  }
}