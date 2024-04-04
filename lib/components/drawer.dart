import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({super.key});
  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  final user = FirebaseAuth.instance.currentUser?.email;

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
              child: Image.asset(Get.isDarkMode ? 'assets/img/nak_letters_bw.png' : 'assets/img/nak_letters.png',),
            ),
            ListTile(
              title: Text('Signed in as: $user'),
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
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: Text('Digital ID', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/id'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('My Profile', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('My Account', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/account'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Logout', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/auth');
              }
            ),
            const SizedBox(height: 35,),
            ListTile(
              title: Text('Follow us on:', style: theme.TextThemes.drawerMenuNT(context),),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      // this method is used to launch app links
                      launchUrl(
                        Uri.parse('https://www.instagram.com/nualphakappa/'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    icon:  const FaIcon(FontAwesomeIcons.facebook, size: 38.0,),
                  ),
                  IconButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse('https://www.instagram.com/nualphakappa/'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    icon:  const FaIcon(FontAwesomeIcons.instagram, size: 38.0,),
                  ),
                  IconButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse('https://www.youtube.com/1988NAKOS'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    icon:  const FaIcon(FontAwesomeIcons.youtube, size: 38.0,),
                  ),
                  IconButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse('https://x.com/nualphakappa?s=21&t=FoEIq1vlgmsd5V20-ZQP1w'),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    icon:  const FaIcon(FontAwesomeIcons.xTwitter, size: 38.0,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
    );
  }
}
