import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/constants.dart' as constants;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          // const Icon(Icons.message_outlined),
          // const SizedBox(width: 10,),
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('88', style: theme.TextThemes.versionYear(context)),
              const SizedBox(height: 160,),
              Container(
                height: 46,
                width: 100,
                decoration: BoxDecoration(
                  color: theme.lightGrey,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(child: Text(constants.appVersion, style: theme.TextThemes.versionNum(context),)),
              ),
              const SizedBox(height: 15,),
              Text('NU ALPHA', style: theme.TextThemes.versionHeadline(context),),
              Text('KAPPA', style: theme.TextThemes.versionHeadline(context),),
              Text('FRATERNITY', style: theme.TextThemes.versionHeadline(context),),
              const SizedBox(height: 6,),
              Text('Mind.Culture.Pride.', style: theme.TextThemes.versionSlogan(context),),
              const SizedBox(height: 20,),
              Text('Developed by: Sandro Aguilar, ID #33', style: theme.TextThemes.versionDesign(context),),
              const SizedBox(height: 45,),
              Text('SOURCE CODE', style: theme.TextThemes.versionHeadlineMed(context),),
              const SizedBox(height: 4,),
              Text('The NAK App is an open-source project hosted on Github.com and is accessible to anyone willing to join the developer group. Email developer@nakinc.org to get access to the repo.', style: theme.TextThemes.versionDesign(context),),
              const SizedBox(height: 6,),
              OutlinedButton(
                onPressed: () {
                  final Uri toLaunch = Uri(scheme: 'https', host: 'www.github.com', path: '/sunny-aguilar/nak-mobile');
                  Future<void> launchInWebView({required Uri url}) async {
                    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                      throw Exception('Could not launch $url');
                    }
                  }
                  launchInWebView(url: toLaunch);
                  },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(FontAwesomeIcons.github, color: theme.azureClr,), SizedBox(width: 12,), Text('Github', style: TextStyle(color: theme.azureClr,), ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Text('SUPPORT THE APP', style: theme.TextThemes.versionHeadlineMed(context),),
              const SizedBox(height: 6,),
              Text('There are a ton of ways you can donate to the NAK app. We are looking for anyone with coding and testing skills. Send an email to developer@nakinc.org to ask learn more.', style: theme.TextThemes.versionDesign(context),),
              const SizedBox(height: 60,),
            ],
          ),
        ),
      ),
    );
  }
}