import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nak_app/components/revenuecat/paywall.dart';
import 'package:nak_app/components/revenuecat/constants.dart';
import 'package:nak_app/components/revenuecat/native_dialog.dart';

class RC extends StatefulWidget {
  const RC({super.key});
  @override
  State<RC> createState() => _RCState();
}

class _RCState extends State<RC> {
  bool _isLoading = false;

  // show Paywall
  void performMagic(val) async {

    setState(() {
      _isLoading = true;
    });

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID]?.isActive == true) {
      // if user has entitlement, allow premium function
      setState(() {
        _isLoading = false;
      });
    }
    else {
      Offerings? offerings;
      try {
        offerings = await Purchases.getOfferings();
      }
      on PlatformException catch (e) {
        if (mounted) {
          await showDialog(
            context: context,
            builder: (BuildContext context) => ShowDialogToDismiss(
              title: 'Error',
              content: e.message ?? 'Unknown error',
              buttonText: 'OK'
            )
          );
        }
      }

      setState(() {
        _isLoading = false;
      });

      if (offerings == null || offerings.current == null) {
        // offerings are empty, show a message to user
      }
      else {
        if (mounted) {
          await showModalBottomSheet(
            useRootNavigator: true,
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: theme.kColorBackground,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Paywall(
                    offering: offerings!.current!,
                  );
                }
              );
            }
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

