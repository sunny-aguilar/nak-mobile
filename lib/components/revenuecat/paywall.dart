import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nak_app/components/revenuecat/constants.dart';
import 'package:nak_app/components/revenuecat/singletons_data.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class Paywall extends StatefulWidget {
  const Paywall({super.key, required this.offering});
  final Offering offering;
  @override
  State<Paywall> createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: theme.voidClr,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))
              ),
              child: Center(
                child: Text('NAK App Premium', style: theme.TextThemes.titleTextStyle(context)),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(top: 32.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: Text('NAK APP PREMIUM', style: theme.TextThemes.descriptionTextStyle(context),),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.offering.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                var myProductList = widget.offering.availablePackages;
                return Card(
                  color: theme.voidClr,
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
              padding: const EdgeInsets.only(top: 32.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text(
                  footerText,
                  style: theme.TextThemes.descriptionTextStyle(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}