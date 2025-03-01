import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class ComplianceGuage extends StatelessWidget {
  const ComplianceGuage({super.key, required this.progressValue});
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: SfRadialGauge(
        axes: [
          RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              thickness: 0.25,
              cornerStyle: CornerStyle.bothCurve,
              color: theme.lightGrey,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: progressValue,
                width: 0.25,
                color: theme.redClr,
                pointerOffset: 0,
                cornerStyle: CornerStyle.bothCurve,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                positionFactor: 0.1,
                angle: 90,
                widget: Text('${progressValue.toStringAsFixed(0)}%', style: theme.TextThemes.size10(context),),
              )
            ],
          ),
        ],
      ),
    );
  }
}