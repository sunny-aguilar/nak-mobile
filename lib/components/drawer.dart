import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: theme.Themes.light.primaryColor,
      child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 254, 58, 67),
              ),
              child: Text(
                'Nu Alpha Kappa Fraternity, Inc.',
                style: theme.TextThemes.drawerTitle(context),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.holiday_village, color: theme.darkGreyClr,),
              title: Text('Chapters', style: theme.TextThemes.drawerMenu(context),
                // style: Theme.of(context).textTheme.titleLarge!
              ),
              onTap: () => Navigator.pushNamed(context, '/chapters'),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money, color: theme.darkGreyClr,),
              title: Text('Dues', style: theme.TextThemes.drawerMenu(context)),
              onTap: () => Navigator.pushNamed(context, '/dues'),
            ),
            ListTile(
              leading: const Icon(Icons.remember_me, color: theme.darkGreyClr,),
              title: Text('National Board', style: theme.TextThemes.drawerMenu(context)),
              onTap: () => Navigator.pushNamed(context, '/board'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: theme.darkGreyClr,),
              title: Text('NAKstore', style: theme.TextThemes.drawerMenu(context)),
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
              leading: const Icon(Icons.local_library, color: theme.darkGreyClr,),
              title: Text('Resources', style: theme.TextThemes.drawerMenu(context)),
              onTap: () => Navigator.pushNamed(context, '/resources'),
            ),
            ListTile(
              leading: const Icon(Icons.school, color: theme.darkGreyClr,),
              title: Text('Alumni Network', style: theme.TextThemes.drawerMenu(context)),
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
              leading: const Icon(Icons.public, color: theme.darkGreyClr,),
              title: Text('National Website', style: theme.TextThemes.drawerMenu(context)),
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
              leading: const Icon(Icons.email, color: theme.darkGreyClr,),
              title: Text('Contact Us', style: theme.TextThemes.drawerMenu(context)),
              onTap: () => Navigator.pushNamed(context, '/contact'),
            )
          ],
        ),
    );
  }
}
