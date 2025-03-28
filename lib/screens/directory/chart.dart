import 'package:flutter/material.dart';


class IndividualBar {
  IndividualBar({required this.x, required this.y});
  final int x;
  final double y;
}


class BarData {
  BarData({
    required this.founding,
    required this.alpha,
    required this.beta,
    required this.gamma,
    required this.delta,
    required this.epsilon,
    required this.zeta,
    required this.eta,
    required this.theta,
    required this.iota,
  });
  final double founding;
  final double alpha;
  final double beta;
  final double gamma;
  final double delta;
  final double epsilon;
  final double zeta;
  final double eta;
  final double theta;
  final double iota;

  List<IndividualBar> barData = [];
}

class BarGraph extends StatefulWidget {
  const BarGraph({super.key});
  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  List<double> chapterBrothers = [
    100,120,90,150,110,70,50,110,130,140,120,80,90,60,100,130,70
  ];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
