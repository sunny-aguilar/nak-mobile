import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/drawer.dart' as drawer;
import 'package:nak_app/components/featured_stories.dart' as featured;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/components/scaffolds.dart' as scaffolds;
import 'package:nak_app/components/bottom_nav_bar.dart' as nav;
import 'package:nak_app/screens/chats/chat_rules.dart';

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nak_app/components/revenuecat/paywall.dart';
import 'package:nak_app/components/revenuecat/singletons_data.dart';
import 'package:nak_app/components/revenuecat/constants.dart';
import 'package:nak_app/components/revenuecat/native_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> isAdmin = db.AuthCheck().isAdminOrSuperAdmin('superAdmin');

  // index to track which nav page to show
  int index = 0;

  // lift state up from botton nav class
  void updateIndex(val) {
    setState(() {
      index = val;
    });
  }

  // RevenueCat Paywall
  bool _isLoading = false;

  // show Paywall
  void performMagic(val) async {
    setState(() {
      _isLoading = true;
    });

    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID]?.isActive == true) {
      // if user has entitlement, enter the chat room
      setState(() {
        index = val;
        _isLoading = false;
      });
    }
    else {
      Offerings? offerings;
      try {
        offerings = await Purchases.getOfferings();
      }
      on PlatformException catch (e) {
        await showDialog(
          context: context,
          builder: (BuildContext context) => ShowDialogToDismiss(
            title: 'Error',
            content: e.message ?? 'Unknown error',
            buttonText: 'OK'
          )
        );
      }

      setState(() {
        _isLoading = false;
      });

      if (offerings == null || offerings.current == null) {
        // offerings are empty, show a message to user
      }
      else {
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
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),

      drawer: const drawer.DrawerComponent(),

      body: <Widget>[
        // bottom nav screens
        const featured.HomeScreenChildren(),
        const ChatRules(),
        // ChatScreen(context: context),
      ][index],

      bottomNavigationBar: nav.BottomNavBar(index: index, updateIndex: performMagic,),

      floatingActionButton: FutureBuilder<String>(
        future: isAdmin,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasError) {
            return scaffolds.ScaffoldType().nonadminUser(context);
          }
          else if (snapshot.hasData) {
            if (snapshot.data == 'superAdmin') {
              //return superAdmin floating action button
              return const scaffolds.SpeedDialButton();
            }
            else if (snapshot.data == 'admin') {
              //return admin floating action button
              return scaffolds.ScaffoldType().adminUser(context);
            }
            else {
              return scaffolds.ScaffoldType().nonadminUser(context);
            }
          }
          else {
            return const SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                strokeWidth: 10,
              ),
            );
          }
        },
      ),
    );
  }
}