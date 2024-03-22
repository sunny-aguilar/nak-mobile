import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nak_app/components/auth_check.dart';
import 'package:nak_app/firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nak_app/splash_screen.dart';
import 'package:nak_app/screens/home_screen.dart';
import 'package:nak_app/screens/chapters_screen.dart';
import 'package:nak_app/screens/intro_screeen.dart';
import 'package:nak_app/screens/dues_screen.dart';
import 'package:nak_app/screens/neb_screen.dart';
import 'package:nak_app/screens/resources_screen.dart';
import 'package:nak_app/screens/resource_screen.dart';
import 'package:nak_app/screens/contact_screen.dart';
import 'package:nak_app/screens/digitalid.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((value) => runApp(const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
      final routes = {
        '/auth': (context) => const AuthCheck(),
        '/home': (context) => const HomeScreen(),
        '/intro': (context) => const IntroScreen(),
        '/chapters': (context) => const ChapterScreen(),
        '/dues': (context) => const DuesScreen(),
        '/board': (context) => const NationalBoard(),
        '/resources': (context) => const ResourcesScreen(),
        '/drugs': (context) => const ResourceScreen(),
        '/antihazing': (context) => const ResourceScreen(),
        '/antiretaliation': (context) => const ResourceScreen(),
        '/crisismgmt': (context) => const ResourceScreen(),
        '/ethics': (context) => const ResourceScreen(),
        '/samaritan': (context) => const ResourceScreen(),
        '/riskmgmt': (context) => const ResourceScreen(),
        '/sexualmisconduct': (context) => const ResourceScreen(),
        '/mentalhealth': (context) => const ResourceScreen(),
        '/prevention': (context) => const ResourceScreen(),
        '/titleix': (context) => const ResourceScreen(),
        '/contact': (context) => const ContactScreen(),
        '/id': (context) => const DigitalIDScreen(),
        // '/login': (context) => const LoginScreen(showRegisterPage: ,),
      };

    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: "/",
      routes: routes,
      home: const SplashScreen(),
      theme: theme.CustomTheme.lightThemeData(context),     // theme: is the primary default theme
      darkTheme: theme.CustomTheme.darkThemeData(context),  // darkTheme: primary default dark theme
      /// themeMode: changes the default theme settings (light, dark)
      themeMode: service.ThemeService().theme,
    );
  }
}