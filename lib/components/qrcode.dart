import 'package:flutter/material.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatelessWidget {
  const GenerateQRCode({
    super.key,
    required this.name,
    required this.chapter,
    required this.idNumber,
    required this.email
  });
  final String name;
  final String chapter;
  final String idNumber;
  final String email;

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: 'https://naknet.org/id-badge-confirmation/',
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
    );
  }
}