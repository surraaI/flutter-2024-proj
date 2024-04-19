import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HealthTrackerPage extends StatelessWidget {
  final List<charts.Series<ProgressData, DateTime>> seriesList;
  final bool animate;

  HealthTrackerPage(this.seriesList, {required this.animate});

  factory HealthTrackerPage.withSampleData() {
    return HealthTrackerPage(
      _createSampleData(),
      animate: true,
    );
  }

  static List<charts.Series<ProgressData, DateTime>> _createSampleData() {
    final data = [
      ProgressData(DateTime(2022, 01, 01), 60),
      ProgressData(DateTime(2022, 02, 01), 65),
      ProgressData(DateTime(2022, 03, 01), 70),
      ProgressData(DateTime(2022, 04, 01), 68),
      ProgressData(DateTime(2022, 05, 01), 72),
    ];

    return [
      charts.Series<ProgressData, DateTime>(
        id: 'Progress',
        domainFn: (ProgressData progress, _) => progress.date,
        measureFn: (ProgressData progress, _) => progress.value,
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: charts.TimeSeriesChart(
          seriesList,
          animate: animate,
          // Customize other chart properties as needed
          domainAxis: const charts.DateTimeAxisSpec(
            tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
              day: charts.TimeFormatterSpec(
                format: 'MM/dd',
                transitionFormat: 'MM/dd',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressData {
  final DateTime date;
  final int value;

  ProgressData(this.date, this.value);
}