import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
              ),
              child: Text(
                'Nu Alpha Kappa Fraternity, Inc.',
                style: theme.TextThemes.drawerTitle(context),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.holiday_village,),
              title: Text('Chapters', style: theme.TextThemes.drawerMenuNT(context),
                // style: Theme.of(context).textTheme.titleLarge!
              ),
              onTap: () => Navigator.pushNamed(context, '/chapters'),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money,),
              title: Text('Dues', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/dues'),
            ),
            ListTile(
              leading: const Icon(Icons.remember_me,),
              title: Text('National Board', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/board'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart,),
              title: Text('NAKstore', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () {
                final Uri toLaunch = Uri(scheme: 'https', host: 'shopnualphakappa.com', path: '/');
                Future<void> launchInWebView({required Uri url}) async {
                  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                    throw Exception('Could not launch $url');
                  }
                }
                launchInWebView(url: toLaunch);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_library,),
              title: Text('Resources', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/resources'),
            ),
            ListTile(
              leading: const Icon(Icons.school,),
              title: Text('Alumni Network', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () {
                final Uri toLaunch = Uri(scheme: 'https', host: 'www.naknet.org', path: '/alumni/');
                Future<void> launchInWebView({required Uri url}) async {
                  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                    throw Exception('Could not launch $url');
                  }
                }
                launchInWebView(url: toLaunch);
              },
            ),
            ListTile(
              leading: const Icon(Icons.public,),
              title: Text('National Website', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () {
                // Future<void> launchUrlStart({required String url}) async {
                //   if (!await launchUrl(Uri.parse(url))) {
                //     throw 'Could not launch $url';
                //   }
                // }
                // launchUrlStart(url: 'https://www.naknet.org/');
                // -------------
                final Uri toLaunch = Uri(scheme: 'https', host: 'www.naknet.org', path: '/');
                Future<void> launchInWebView({required Uri url}) async {
                  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                    throw Exception('Could not launch $url');
                  }
                }
                launchInWebView(url: toLaunch);
              },
            ),
            ListTile(
              leading: const Icon(Icons.email,),
              title: Text('Contact Us', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/contact'),
            )
          ],
        ),
    );
  }
}
