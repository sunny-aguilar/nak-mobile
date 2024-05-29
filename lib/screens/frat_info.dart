import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

class FratInfo extends StatelessWidget {
  const FratInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      body: const FratInfoBody(),
    );
  }
}

class FratInfoBody extends StatelessWidget {
  const FratInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            children: <Widget>[
              Text('Fraternity Info', textAlign: TextAlign.center, style: theme.TextThemes.headlineLargeMed(context),),
              const SizedBox(height: 20,),
              Text('Corporate Address', textAlign: TextAlign.left, style: theme.TextThemes.bodyLargeBold(context),),
              const Divider(),
              Text('Nu Alpha Kappa Fraternity\nPO Box 1287\nRoseville, CA 95678', textAlign: TextAlign.center, style: theme.TextThemes.bodyLarge(context),),
              const SizedBox(height: 40,),
              Text('Tax Information', textAlign: TextAlign.left, style: theme.TextThemes.bodyLargeBold(context)),
              const Divider(),
              Text('Nu Alpha Kappa, Inc. is an officially recognized 501(c)(3) organization. Contact the CFO for more information regarding the tax status of Nu Alpha Kappa Fraternity.', textAlign: TextAlign.center, style: theme.TextThemes.bodyLarge(context)),
              const SizedBox(height: 40,),
              Text('Donations', textAlign: TextAlign.left, style: theme.TextThemes.bodyLargeBold(context)),
              const Divider(),
              Text('Most donations made to the national organization Nu Alpha Kappa Fraternity, Inc. are tax deductible. NAK provides tax receipts upon request. Local chapters should inquire to the national office for any questions on donations.', textAlign: TextAlign.center, style: theme.TextThemes.bodyLarge(context)),
            ],
          ),
        ),
      ],
    );
  }
}