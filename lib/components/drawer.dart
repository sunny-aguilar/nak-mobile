import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nak_app/ui/theme.dart' as theme;

const socialMediaLinks = {
  'facebook': 'https://www.facebook.com/nualphakappa/',
  'instagram': 'https://www.instagram.com/nualphakappa/',
  'youtube': 'https://www.youtube.com/1988NAKOS',
  'twitter': 'https://x.com/nualphakappa?s=21&t=FoEIq1vlgmsd5V20-ZQP1w',
};

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({super.key});
  @override
  State<DrawerComponent> createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  final user = FirebaseAuth.instance.currentUser?.displayName;

  Future<void> launchUrlSafe(String url) async {
    try {
      if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open link: $url')),
        );
      }
    }
  }

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
              title: Text(
                user != null ? 'Hello, $user.' : 'Hello, Guest.',
                style: theme.TextThemes.drawerSignInTxt(context),
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
              leading: const FaIcon(FontAwesomeIcons.solidAddressBook,),
              title: Text('Directory', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/directory'),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money,),
              title: Text('Dues', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/dues'),
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: Text('Chapter Finances', style: theme.TextThemes.drawerMenuNT(context),),
              onTap: () => Navigator.pushNamed(context, '/finances'),
            ),
            // ListTile(
            //   leading: const FaIcon(FontAwesomeIcons.listCheck,),
            //   title: Text('Chapter Compliance', style: theme.TextThemes.drawerMenuNT(context),),
            //   onTap: () => Navigator.pushNamed(context, '/compliance'),
            // ),
            ListTile(
              leading: const Icon(Icons.remember_me,),
              title: Text('National Board', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/board'),
            ),
            ListTile(
              leading: const Icon(Icons.document_scanner_outlined),
              title: Text('National Docs', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/docs'),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart,),
              title: Text('NAKstore', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () {
                Navigator.pushNamed(context, '/store');
                // final Uri toLaunch = Uri(scheme: 'https', host: 'shopnualphakappa.com', path: '/');
                // Future<void> launchInWebView({required Uri url}) async {
                //   if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                //     throw Exception('Could not launch $url');
                //   }
                // }
                // launchInWebView(url: toLaunch);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_library,),
              title: Text('Resources', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/resources')
            ),
            // ListTile(
            //   leading: const Icon(Icons.abc),
            //   title: Text('Training', style: theme.TextThemes.drawerMenuNT(context)),
            //   onTap: () => {},
            // ),
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
              // leading: const Icon(Icons.info,),
              leading: const FaIcon(FontAwesomeIcons.buildingColumns,),
              title: Text('Frat Info', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () =>  Navigator.pushNamed(context, '/info'),
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
              leading: const Icon(Icons.badge),
              title: Text('My Profile', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('My Account', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/account'),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.codeBranch, size: 20.0,),
              title: Text('App Version', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () => Navigator.pushNamed(context, '/version'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Logout', style: theme.TextThemes.drawerMenuNT(context)),
              onTap: () async {
                final shouldLogout = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('Cancel', style: theme.TextThemes.drawerMenuNT(context).copyWith(color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('Logout', style: theme.TextThemes.drawerMenuNT(context).copyWith(color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr)),
                      ),
                    ],
                  ),
                );
                if (shouldLogout == true) {
                  FirebaseAuth.instance.signOut();
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, '/auth');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 35,),
            ListTile(
              title: Text('Follow us on:', style: theme.TextThemes.drawerMenuNT(context),),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () => launchUrlSafe(socialMediaLinks['facebook']!),
                    icon:  const FaIcon(FontAwesomeIcons.facebook, size: 38.0,),
                  ),
                  IconButton(
                    onPressed: () => launchUrlSafe(socialMediaLinks['instagram']!),
                    icon: const FaIcon(FontAwesomeIcons.instagram, size: 38.0),
                  ),
                  IconButton(
                    onPressed: () => launchUrlSafe(socialMediaLinks['youtube']!),
                    icon:  const FaIcon(FontAwesomeIcons.youtube, size: 38.0,),
                  ),
                  IconButton(
                    onPressed: () => launchUrlSafe(socialMediaLinks['twitter']!),
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
