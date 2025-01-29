import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class StateChart extends StatelessWidget {
  final Map<String, dynamic> data;

  const StateChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelRotation: -45,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: <ColumnSeries<dynamic, String>>[
        ColumnSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value as num,
          color: Theme.of(context).colorScheme.primary,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.outer,
          ),
        )
      ],
    );
  }
}

class AgeImcChart extends StatelessWidget {
  final Map<String, dynamic> data;

  const AgeImcChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelRotation: -45,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        numberFormat: NumberFormat.decimalPattern(),
      ),
      series: <LineSeries<MapEntry<String, dynamic>, String>>[
        LineSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value as double,
          color: Theme.of(context).colorScheme.secondary,
          width: 3,
          markerSettings: const MarkerSettings(
            isVisible: true,
            height: 6,
            width: 6,
            borderWidth: 2,
          ),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto,
          ),
        )
      ],
    );
  }
}

class ObesityChart extends StatelessWidget {
  final Map<String, dynamic> data;

  const ObesityChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      series: <PieSeries<MapEntry<String, dynamic>, String>>[
        PieSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value as double,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
          ),
          explode: true,
          explodeIndex: 0,
          explodeOffset: '10%',
          radius: '80%',
        )
      ],
    );
  }
}

class BloodTypeAgeChart extends StatelessWidget {
  final Map<String, dynamic> data;

  const BloodTypeAgeChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        numberFormat: NumberFormat.decimalPattern(),
      ),
      series: <BarSeries<MapEntry<String, dynamic>, String>>[
        BarSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value as double,
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(4),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.auto,
          ),
        )
      ],
    );
  }
}

class DonorsPerReceiverChart extends StatelessWidget {
  final Map<String, dynamic> data;

  const DonorsPerReceiverChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelRotation: -45,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: <ColumnSeries<MapEntry<String, dynamic>, String>>[
        ColumnSeries(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value as num,
          color: Theme.of(context).colorScheme.primaryContainer,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.outer,
          ),
          borderRadius: BorderRadius.circular(4),
        )
      ],
    );
  }
}
