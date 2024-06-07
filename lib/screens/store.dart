import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

class NakStore extends StatelessWidget {
  const NakStore({super.key});

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
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Featured Products', style: theme.TextThemes.headlineLarge(context),),
                Text('NAK Polo', style: theme.TextThemes.headlineMedLarge(context),),
                Text('NAK Dri-FIT Nike Polo', style: theme.TextThemes.headlineSmall20(context),),
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    color: theme.lightGrey,
                  ),
                ),
                const SizedBox(height: 6,),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: theme.primaryClr,
                      backgroundColor: theme.azureClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)
                      ),
                    ),
                    child: const Text('See Item'),
                  ),
                ),
                const SizedBox(height: 40,),
                Text('Graduation Sashes', style: theme.TextThemes.headlineMedLarge(context),),
                Text('Bachelors, Masters and PhD', style: theme.TextThemes.headlineSmall20(context),),
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    color: theme.lightGrey,
                  ),
                ),
                const SizedBox(height: 6,),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: theme.primaryClr,
                      backgroundColor: theme.azureClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)
                      ),
                    ),
                    child: Text('See Item'),
                  ),
                ),
                const SizedBox(height: 40,),
                Text('Item Name', style: theme.TextThemes.headlineMedLarge(context),),
                Text('Item Description', style: theme.TextThemes.headlineSmall20(context),),
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    color: theme.lightGrey,
                  ),
                ),
                const SizedBox(height: 6,),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: theme.primaryClr,
                      backgroundColor: theme.azureClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)
                      ),
                    ),
                    child: Text('See Item'),
                  ),
                ),
                const SizedBox(height: 40,),
                Text('Custom Options', style: theme.TextThemes.headlineLarge(context),),
                Text(
                  'Most apparel can be customized to suit your needs. Although complex customizations are not being done, you can add simple customizations by simply contacting the store.',
                  style: theme.TextThemes.headlineSmall20(context), textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40,),
              ],
            ),
          ),
        ),
      ),
    );

  }
}