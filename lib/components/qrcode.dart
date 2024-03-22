import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatelessWidget {
  const GenerateQRCode({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.chapter,
    required this.lineNumber,
    required this.status,
    required this.nakID,
  });
  final String firstName;
  final String lastName;
  final String chapter;
  final String lineNumber;
  final String status;
  final String nakID;

  @override
  Widget build(BuildContext context) {
    // edit this string to modify the naknet.org/id-badge-confirmation page
    String siteURL = 'https://naknet.org/id-badge-confirmation?firstName=$firstName&lastName=$lastName&chapter=$chapter&lineNumber=$lineNumber&status=$status&nakID=$nakID';
    return GestureDetector(
      onTap: () {
        Future<void> launchUrlStart({required String url}) async {
          if (!await launchUrl(Uri.parse(url))) {
            throw 'Could not launch $url';
          }
        }
        launchUrlStart(url: siteURL);
      },
      child: QrImageView(
        data: siteURL,
        version: QrVersions.auto,
        gapless: true,
        backgroundColor: theme.primaryClr,
        size: 220.0,
        errorStateBuilder: (cxt, err) {
          return const Center(
            child: Text(
              'Uh oh! Something went wrong...',
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}