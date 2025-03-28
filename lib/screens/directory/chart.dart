import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nak_app/ui/theme.dart' as theme;


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

  void initializedBarData() {
    barData = [
      IndividualBar(x: 0, y: founding),
      IndividualBar(x: 1, y: alpha),
      IndividualBar(x: 2, y: beta),
      IndividualBar(x: 3, y: gamma),
      IndividualBar(x: 4, y: delta),
      IndividualBar(x: 5, y: epsilon),
      IndividualBar(x: 6, y: zeta),
      IndividualBar(x: 7, y: eta),
      IndividualBar(x: 8, y: theta),
      IndividualBar(x: 9, y: iota),
    ];
  }
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


class MyBarGraph extends StatelessWidget {
  const MyBarGraph({super.key, required this.chapterBrothers});
  final List chapterBrothers;

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      founding: chapterBrothers[0],
      alpha: chapterBrothers[1],
      beta: chapterBrothers[2],
      gamma: chapterBrothers[3],
      delta: chapterBrothers[4],
      epsilon: chapterBrothers[5],
      zeta: chapterBrothers[6],
      eta: chapterBrothers[7],
      theta: chapterBrothers[8],
      iota: chapterBrothers[9]
    );

    myBarData.initializedBarData();

    return BarChart(
      BarChartData(
        maxY: 200,
        minY:0,
        barGroups: myBarData.barData.map(
          (data) => BarChartGroupData(
            x: data.x,
            barRods: [
              BarChartRodData(
                toY: data.y,
                color: theme.darkGreyClr,
                width: 10,
                borderRadius: BorderRadius.circular(2),
              )
            ]
          ),
        ).toList(),
      )
    );
  }
}
