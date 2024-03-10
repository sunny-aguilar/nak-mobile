import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nak_app/ui/theme.dart' as theme;

// red solid button
class RedButton extends StatelessWidget {
  final String text;
  final String url;
  const RedButton({super.key, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        padding: const EdgeInsets.all(20),
        backgroundColor: theme.redClr,
        foregroundColor: theme.whiteClr,
        side: const BorderSide(color: theme.redClr),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textStyle: theme.TextThemes.button1(context),
      ),
      child: Text(text),
      onPressed: () {
        Future<void> launchUrlStart({required String url}) async {
          if (!await launchUrl(Uri.parse(url))) {
            throw 'Could not launch $url';
          }
        }
        launchUrlStart(url: url);
      },
    );
  }
}

// red outline button
class RedOutlineButton extends StatelessWidget {
  final String text;
  final String url;
  const RedOutlineButton({super.key, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        padding: const EdgeInsets.all(20),
        backgroundColor: theme.darkGreyClr,
        foregroundColor: theme.redClr,
        side: const BorderSide(color: theme.redClr, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textStyle: theme.TextThemes.button1(context),
      ),
      child: Text(text),
      onPressed: () {
        Future<void> launchUrlStart({required String url}) async {
          if (!await launchUrl(Uri.parse(url))) {
            throw 'Could not launch $url';
          }
        }
        launchUrlStart(url: url);
      },
    );
  }
}