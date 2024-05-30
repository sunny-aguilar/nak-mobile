import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nak_app/components/revenuecat/constants.dart';
import 'package:nak_app/components/revenuecat/singletons_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class Paywall extends StatefulWidget {
  const Paywall({super.key, required this.offering});
  final Offering offering;
  @override
  State<Paywall> createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {

  void restorePurchase() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      // ... check restored purchaserInfo to see if entitlement is now active
    } on PlatformException catch (e) {
      // Error restoring purchases
      print('Restore purchases error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: <Widget>[
          Container(
            height: 70.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0))
            ),
            child: Center(
              child: Text('NAK App Premium', style: theme.TextThemes.titleTextStyle(context)),
            ),
          ),
          ColoredBox(
            color: Get.isDarkMode ? theme.voidClr : theme.primaryClr,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 16.0, left: 16.0, right: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text('ANNUAL PLAN', style: theme.TextThemes.descriptionTextStyle(context),),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.offering.availablePackages.length,
                  itemBuilder: (BuildContext context, int index) {
                    var myProductList = widget.offering.availablePackages;
                    return Card.outlined(
                      color: Get.isDarkMode ? theme.darkGreyClr : theme.offWhiteClr,
                      child: ListTile(
                        onTap: () async {
                          try {
                            CustomerInfo customerInfo = await Purchases.purchasePackage(myProductList[index]);
                            EntitlementInfo? entitlement = customerInfo.entitlements.all[entitlementID];
                            appData.entitlementIsActive = entitlement?.isActive ?? false;
                          }
                          catch (e) {
                            print(e);
                          }
                          setState(() {});
                          Navigator.pop(context);
                        },
                        title: Text(
                           myProductList[index].storeProduct.title,
                          style: theme.TextThemes.titleTextStyle(context),
                        ),
                        subtitle: Text(
                          myProductList[index].storeProduct.description,
                          style: theme.TextThemes.descriptionTextStyle(context).copyWith(
                            fontSize: 10.0,
                          )
                        ),
                        trailing: Text(
                          myProductList[index].storeProduct.priceString,
                          style: theme.TextThemes.titleTextStyle(context),
                        ),
                      ),
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 20.0, left: 16.0, right: 16.0),
                  child: TextButton(
                    onPressed: () => restorePurchase(),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.darkGreyClr,
                    ),
                    child: const Text('Restore'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0),
                  child: SizedBox(
                    child: Text(
                      footerText,
                      style: theme.TextThemes.descriptionTextStyle(context).copyWith(fontSize: 14.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 2.0, left: 16.0, right: 16.0),
                  child: TextButton(
                    onPressed: () {
                      final Uri toLaunch = Uri(scheme: 'https', host: 'www.naknet.org', path: '/nak-app-terms-of-service/');
                      Future<void> launchInWebView({required Uri url}) async {
                        if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                          throw Exception('Could not launch $url');
                        }
                      }
                      launchInWebView(url: toLaunch);
                    },
                    child: Text('Terms of Service', style: theme.TextThemes.dynamic(context),)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 40.0, left: 16.0, right: 16.0),
                  child: TextButton(
                    onPressed: () {
                      final Uri toLaunch = Uri(scheme: 'https', host: 'www.naknet.org', path: '/nak-app-privacy-policy/');
                      Future<void> launchInWebView({required Uri url}) async {
                        if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                          throw Exception('Could not launch $url');
                        }
                      }
                      launchInWebView(url: toLaunch);
                    },
                    style: TextButton.styleFrom(
                      // foregroundColor: theme.darkGreyClr,
                    ),
                    child: Text('Privacy Policy', style: theme.TextThemes.dynamic(context),)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}