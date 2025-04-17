import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;


class IndividualBar {
  IndividualBar({required this.x, required this.y});
  final int x;    // position on x axis
  final double y; // position on y axis
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
    required this.xi,
    required this.omicron,
    required this.pi,
    required this.rho,
    required this.sigma,
    required this.tau,
    required this.upsilon,
    required this.phi,
    required this.chi,
    required this.psi,
    required this.aa,
    required this.ab,
    required this.ag,
    required this.ad,
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
  final double xi;
  final double omicron;
  final double pi;
  final double rho;
  final double sigma;
  final double tau;
  final double upsilon;
  final double phi;
  final double chi;
  final double psi;
  final double aa;
  final double ab;
  final double ag;
  final double ad;

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
      IndividualBar(x: 13, y: nu),
      IndividualBar(x: 14, y: xi),
      IndividualBar(x: 15, y: omicron),
      IndividualBar(x: 16, y: pi),
      IndividualBar(x: 17, y: rho),
      IndividualBar(x: 18, y: sigma),
      IndividualBar(x: 19, y: tau),
      IndividualBar(x: 20, y: upsilon),
      IndividualBar(x: 21, y: phi),
      IndividualBar(x: 22, y: chi),
      IndividualBar(x: 23, y: psi),
      IndividualBar(x: 24, y: aa),
      IndividualBar(x: 25, y: ab),
      IndividualBar(x: 26, y: ag),
      IndividualBar(x: 27, y: ad),
    ];
  }
}


class MyBarGraph extends StatelessWidget {
  const MyBarGraph({super.key, required this.chapterBrothers});
  final List chapterBrothers; // auto grow graph based on largest list (chapter size)

  double getLargest(List arr) {
    double largest = 0;
    for (final num in arr) {
      if (num > largest) {
        largest = num;
      }
    }
    return largest;
  }

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
      kappa: chapterBrothers[10],
      lambda: chapterBrothers[11],
      mu: chapterBrothers[12],
      nu: chapterBrothers[13],
      xi: chapterBrothers[14],
      omicron: chapterBrothers[15],
      pi: chapterBrothers[16],
      rho: chapterBrothers[17],
      sigma: chapterBrothers[18],
      tau: chapterBrothers[19],
      upsilon: chapterBrothers[20],
      phi: chapterBrothers[21],
      chi: chapterBrothers[22],
      psi: chapterBrothers[23],
      aa: chapterBrothers[24],
      ab: chapterBrothers[25],
      ag: chapterBrothers[26],
      ad: chapterBrothers[27],
    );

    myBarData.initializedBarData();

    return BarChart(
      BarChartData(
        maxY: getLargest(chapterBrothers)+35,   // increase this size as the chapter bro count grows...
        minY:0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        backgroundColor: Get.isDarkMode ? theme.uiRedClr : theme.uiGrey,
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Get.isDarkMode ? theme.primaryClr : theme.redClr,
            tooltipHorizontalAlignment: FLHorizontalAlignment.right,
            tooltipMargin: -10,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${chapterBrothers[groupIndex]}',
                TextStyle(fontSize: 16, color: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr)
              );
            },
          ),
        ),

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
                // color: theme.softWhiteUI,
                color: Get.isDarkMode ? theme.softWhiteUI : theme.uiRedClr,
                width: 8,
                borderRadius: BorderRadius.circular(4),
              )
            ]
          ),
        ).toList(),
      )
    );
  }
}


TextStyle chartLabelText() {
  return TextStyle(
    fontSize: 10,
    color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
  );
}


Widget getBottomTitles(double value, TitleMeta meta) {
  Widget text;
  // double fontSize = 10;

  switch (value.toInt()) {
    case 0:
      text = Text('F', style: chartLabelText());
      break;
    case 1:
      text = Text('A', style: chartLabelText());
      break;
    case 2:
      text = Text('B', style: chartLabelText());
      break;
    case 3:
      text = Text('Γ', style: chartLabelText());
      break;
    case 4:
      text = Text('Δ', style: chartLabelText());
      break;
    case 5:
      text = Text('E', style: chartLabelText());
      break;
    case 6:
      text = Text('Z', style: chartLabelText());
      break;
    case 7:
      text = Text('H', style: chartLabelText());
      break;
    case 8:
      text = Text('Θ', style: chartLabelText());
      break;
    case 9:
      text = Text('I', style: chartLabelText());
      break;
    case 10:
      text = Text('K', style: chartLabelText());
      break;
    case 11:
      text = Text('Λ', style: chartLabelText());
      break;
    case 12:
      text = Text('M', style: chartLabelText());
      break;
    case 13:
      text = Text('N', style: chartLabelText());
      break;
    case 14:
      text = Text('Ξ', style: chartLabelText());
      break;
    case 15:
      text = Text('O', style: chartLabelText());
      break;
    case 16:
      text = Text('Π', style: chartLabelText());
      break;
    case 17:
      text = Text('P', style: chartLabelText());
      break;
    case 18:
      text = Text('Σ', style: chartLabelText());
      break;
    case 19:
      text = Text('T', style: chartLabelText());
      break;
    case 20:
      text = Text('Y', style: chartLabelText());
      break;
    case 21:
      text = Text('Φ', style: chartLabelText());
      break;
    case 22:
      text = Text('X', style: chartLabelText());
      break;
    case 23:
      text = Text('Ψ', style: chartLabelText());
      break;
    case 24:
      text = Text('AA', style: chartLabelText());
      break;
    case 25:
      text = Text('AB', style: chartLabelText());
      break;
    case 26:
      text = Text('AΓ', style: chartLabelText());
      break;
    case 27:
      text = Text('AΔ', style: chartLabelText());
      break;
    default:
      text = Text('');
  }

  return SideTitleWidget(
    meta: meta,
    child: text,
  );
}