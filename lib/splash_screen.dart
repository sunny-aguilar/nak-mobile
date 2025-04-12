import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nak_app/components/auth_check.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/constants.dart' as constants;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(milliseconds: 2800), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        // check if user is logged in
        builder: (_) => const AuthCheck(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: CustomScaffold(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ClipPath(
                  clipper: BronzeBannerClipper(),
                  child: Container(
                    // width: 400,
                    height: 600,
                    color: const Color.fromARGB(255, 200, 183, 131),
                    ),
                ),
                ClipPath(
                  clipper: WhiteBannerClipper(),
                  child: Container(
                    // width: 400,
                    height: 500,
                    color: const Color.fromARGB(255, 241, 241, 241),
                    ),
                ),
                ClipPath(
                  clipper: RedBannerClipper(),
                  child: Container(
                    // width: 400,
                    height: 400,
                    color: const Color.fromARGB(255, 196, 18, 48),
                  ),
                ),
                Image.asset('assets/img/nak_letters.png', height: 130.0,),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        // theme.darkGreyClr.withOpacity(0.5),
                        theme.darkGreyClr.withAlpha(128),
                      ),
                    ),
                  ),
                ),

              ],
            ),
            // const SizedBox(height: 100,),
                Text(constants.appVersion, style: theme.TextThemes.headlineXSmall14(context),)
          ],
        ),
      ),
    );
  }
}

class BronzeBannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.moveTo(size.width/2, 0);
    path.lineTo(0, (size.height/6)*3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, (size.height/6)*3);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class WhiteBannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, (size.height/5)*2);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, (size.height/5)*3);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class RedBannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height/4);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, (size.height/4)*3);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}