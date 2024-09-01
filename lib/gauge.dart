import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// ignore: must_be_immutable, camel_case_types
class gauge extends StatelessWidget {
  String title;
  double max;
  double current;

  gauge(
      {super.key,
      required this.title,
      required this.max,
      required this.current});
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      title: GaugeTitle(text: title),
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: max,
          pointers: [
            NeedlePointer(
                value: current,
                enableAnimation: true,
                animationDuration: 1000,
                animationType: AnimationType.ease),
            RangePointer(
              value: current,
              enableAnimation: true,
              animationType: AnimationType.ease,
              animationDuration: 1000,
            )
          ],
        ),
      ],
    );
  }
}
