import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}

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
                const SizedBox(height: 10,),
                Text('NAK Polo', style: theme.TextThemes.headlineMedLarge(context),),
                Text('NAK Dri-FIT Nike Polo', textAlign: TextAlign.center, style: theme.TextThemes.headlineSmall20(context),),
                Image.network(
                  'https://drive.google.com/uc?export=view&id=1VPCwsWZqQRrLlbHQWxcy69jIzV3NvTNz',
                  cacheWidth: 160.cacheSize(context),
                ),
                const SizedBox(height: 6,),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                    onPressed: () {
                      final Uri toLaunch = Uri(scheme: 'https', host: 'shopnualphakappa.com', path: '/collections/polos/products/nak-logo-dri-fit-nike-polo');
                        Future<void> launchInWebView({required Uri url}) async {
                          if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                            throw Exception('Could not launch $url');
                          }
                        }
                      launchInWebView(url: toLaunch);
                    },
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
                Text('Bachelors, Masters and PhD', textAlign: TextAlign.center, style: theme.TextThemes.headlineSmall20(context),),
                Image.network(
                  'https://drive.google.com/uc?export=view&id=1e7Sme97MdwtUwh9HRfLX_C8gdbtc5vPp',
                  cacheWidth: 160.cacheSize(context),
                ),
                const SizedBox(height: 6,),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                    onPressed: () {
                      final Uri toLaunch = Uri(scheme: 'https', host: 'shopnualphakappa.com', path: '/collections/graduation/products/bachelor-degree-stole');
                        Future<void> launchInWebView({required Uri url}) async {
                          if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                            throw Exception('Could not launch $url');
                          }
                        }
                      launchInWebView(url: toLaunch);
                    },
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
                Text('Stitched Hoodie', style: theme.TextThemes.headlineMedLarge(context),),
                Text('Heavyweight hooded sweatshirt with stitched twill letters', textAlign: TextAlign.center, style: theme.TextThemes.headlineSmall20(context),),
                Image.network(
                  'https://drive.google.com/uc?export=view&id=1xZHqT7Ctbx2mzaata4fKxiP0poiPxsvE',
                  cacheWidth: 160.cacheSize(context),
                ),
                const SizedBox(height: 6,),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: TextButton(
                    onPressed: () {
                      final Uri toLaunch = Uri(scheme: 'https', host: 'shopnualphakappa.com', path: '/collections/outwear/products/classic-stitched-applique-block-letters-hoodie');
                        Future<void> launchInWebView({required Uri url}) async {
                          if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                            throw Exception('Could not launch $url');
                          }
                        }
                      launchInWebView(url: toLaunch);
                    },
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
                Text('Custom Options', style: theme.TextThemes.headlineLarge(context),),
                Text(
                  'Most apparel can be customized to suit your needs. Although complex customizations are not being done, you can add simple customizations by simply contacting the store via email at ',
                  style: theme.TextThemes.headlineSmall20(context), textAlign: TextAlign.center,
                ),
                Text(
                  'store@nakinc.org.',
                  style: theme.TextThemes.headlineSmall20(context).copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center,
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