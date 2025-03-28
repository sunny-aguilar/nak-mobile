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
    required this.kappa,
    required this.lambda,
    required this.mu,
    required this.nu,
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
  final double kappa;
  final double lambda;
  final double mu;
  final double nu;

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
      IndividualBar(x: 10, y: kappa),
      IndividualBar(x: 11, y: lambda),
      IndividualBar(x: 12, y: mu),
      IndividualBar(x: 12, y: nu),
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
      iota: chapterBrothers[9],
      kappa: chapterBrothers[9],
      lambda: chapterBrothers[9],
      mu: chapterBrothers[9],
      nu: chapterBrothers[9],
    );

    myBarData.initializedBarData();

    return BarChart(
      BarChartData(
        maxY: 200,
        minY:0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            )
          ),
        ),
        barGroups: myBarData.barData.map(
          (data) => BarChartGroupData(
            x: data.x,
            barRods: [
              BarChartRodData(
                toY: data.y,
                color: theme.darkGreyClr,
                width: 12,
                borderRadius: BorderRadius.circular(0),
              )
            ]
          ),
        ).toList(),
      )
    );
  }
}


Widget getBottomTitles(double value, TitleMeta meta) {
  Widget text;

  switch (value.toInt()) {
    case 0:
      text = const Text('F');
      break;
    case 1:
      text = const Text('A');
      break;
    case 2:
      text = const Text('B');
      break;
    case 3:
      text = const Text('Γ');
      break;
    case 4:
      text = const Text('Δ');
      break;
    case 5:
      text = const Text('E');
      break;
    case 6:
      text = const Text('Z');
      break;
    case 7:
      text = const Text('H');
      break;
    case 8:
      text = const Text('Θ');
      break;
    case 9:
      text = const Text('I');
      break;
    case 10:
      text = const Text('K');
      break;
    case 11:
      text = const Text('Λ');
      break;
    case 12:
      text = const Text('M');
      break;
    case 13:
      text = const Text('N');
      break;
    case 14:
      text = const Text('Ξ');
      break;
    case 15:
      text = const Text('O');
      break;
    case 16:
      text = const Text('Π');
      break;
    case 17:
      text = const Text('P');
      break;
    case 18:
      text = const Text('Σ');
      break;
    case 19:
      text = const Text('T');
      break;
    case 20:
      text = const Text('Y');
      break;
    case 21:
      text = const Text('Φ');
      break;
    case 22:
      text = const Text('X');
      break;
    case 23:
      text = const Text('Ψ');
      break;
    case 24:
      text = const Text('AA');
      break;
    case 25:
      text = const Text('AB');
      break;
    case 26:
      text = const Text('AΓ');
      break;
    case 27:
      text = const Text('AΔ');
      break;
    default:
      text = const Text('');
  }

  return SideTitleWidget(
    meta: meta,
    child: text,
  );
}