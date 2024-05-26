import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:nak_app/components/revenuecat/constants.dart';
import 'package:nak_app/components/revenuecat/singletons_data.dart';


class Paywall extends StatefulWidget {
  const Paywall({super.key, required this.offering});
  final Offering offering;
  @override
  State<Paywall> createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}