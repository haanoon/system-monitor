import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// ignore: must_be_immutable
class Gauge1 extends StatelessWidget {
  Gauge1({super.key, required this.title, required this.value});
  String title;
  double value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
        GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
        GaugeRange(startValue: 50, endValue: 100, color: Colors.orange),
        GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
      ], pointers: <GaugePointer>[
        NeedlePointer(value: value)
      ], annotations: <GaugeAnnotation>[
        GaugeAnnotation(
            widget: Text(title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            angle: 90,
            positionFactor: 0.5)
      ])
    ]));
  }
}
