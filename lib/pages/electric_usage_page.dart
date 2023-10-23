import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/electric_chart.dart';
import '../widgets/responsive_widget.dart';

class ElectricUsagePage extends StatelessWidget {
  const ElectricUsagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> electricUsageData = [20, 14, 19, 22, 23, 28, 27];
    final List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Electric Usage'),
      ),
      body: SingleChildScrollView(
        child: ResponsiveWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Usage Per Device',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const ElectricBarChart(),
              const SizedBox(height: 40),
              Text(
                'Total Weekly Usage',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const ElectricLineChart(),
              const SizedBox(height: 40),
              Text(
                'Daily Stats',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: daysOfWeek.length,
                  itemBuilder: (ctx, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: ListTile(
                          title: Text(
                            daysOfWeek[i],
                            style: const TextStyle(fontSize: 16),
                          ),
                          trailing: Text(
                            '${electricUsageData[i]} kwh',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ))
            ]
                .animate(interval: 100.ms)
                .fadeIn(duration: 200.ms)
                .slideX(duration: 200.ms, curve: Curves.easeInOut),
          ),
        ),
      ),
    );
  }
}
