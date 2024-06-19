import 'package:flutter/material.dart';

/// A type representing the various available data points
enum DataPoint {
  casesTotal('Total Cases', 'assets/count.png', Color(0xFFFFF492)),
  casesActive('Active Cases', 'assets/fever.png', Color(0xFFE99600)),
  deaths('Deaths', 'assets/death.png', Color(0xFFE40000)),
  recovered('Recovered', 'assets/patient.png', Color(0xFF70A901));

  const DataPoint(this.name, this.assetPath, this.color);
  final String name;
  final String assetPath;
  final Color color;
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('COVID-19 Tracker'),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: SizedBox(
              width: 500, // max allowed width
              child: Dashboard(),
            ),
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Some random values
    final values = [
      9231249,
      123214,
      51245,
      7452340,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final dataPoint in DataPoint.values)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DataCard(
              dataPoint: dataPoint,
              value: values[dataPoint.index],
            ),
          ),
      ],
    );
  }
}

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.dataPoint,
    required this.value,
  });

  final DataPoint dataPoint;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: dataPoint.color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dataPoint.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: dataPoint.color,
                  ),
                ),
                const SizedBox(height: 8.0),
                Image.asset(
                  dataPoint.assetPath,
                  width: 50,
                  height: 50,
                  color: dataPoint.color,
                ),
              ],
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                value.toStringWithCommas(),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: dataPoint.color,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on int {
  String toStringWithCommas() {
    return RegExp(r'(\d+)(?=(\d{3})+(?!\d))')
        .allMatches(toString())
        .fold<String>(
          '',
          (prev, match) =>
              '${prev}${(prev.isNotEmpty ? ',' : '')}${match.group(1)}',
        );
  }
}
