import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ElectricLineChart extends StatelessWidget {
  const ElectricLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return AspectRatio(
      aspectRatio: 5 / 4,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: _bottomAxisTiles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 65,
                getTitlesWidget: (value, meta) {
                  String text = '';
                  if (value % 5 == 0 && value > 5) {
                    text = '${value.toInt()}kwh';
                  }
                  return Text(text);
                },
              ),
            ),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
                drawBelowEverything: false,
                axisNameSize: 0),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.transparent,
              width: 1,
            ),
          ),
          minX: 0, // Min value for x-axis (Monday)
          maxX: 6, // Max value for x-axis (Sunday)
          minY: 5, // Min value for y-axis
          maxY: 30, // Max value for y-axis
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 20), // Monday
                const FlSpot(1, 14), // Tuesday
                const FlSpot(2, 19), // Wednesday
                const FlSpot(3, 22), // Thursday
                const FlSpot(4, 23), // Friday
                const FlSpot(5, 28), // Saturday
                const FlSpot(6, 27), //Sunday
              ],
              isCurved: true,
              color: color,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.5), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              barWidth: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class ElectricBarChart extends StatelessWidget {
  const ElectricBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white12, borderRadius: BorderRadius.circular(20)),
        child: BarChart(
          BarChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              bottomTitles: _bottomAxisTiles2(),
              rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                  drawBelowEverything: false,
                  axisNameSize: 0),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.transparent,
                width: 1,
              ),
            ),
            minY: 5,
            maxY: 35,
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    fromY: 0,
                    toY: 30, // Air Conditioner (30 KWh)
                    color: color,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    fromY: 0,
                    toY: 15, // Smart Light (15 KWh)
                    color: color,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    fromY: 0,
                    toY: 10, // Smart TV (10 KWh)
                    color: color,
                  ),
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    fromY: 0,
                    toY: 20, // Speaker (20 KWh)
                    color: color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AxisTitles _bottomAxisTiles() {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 0:
            text = 'Mo';
          case 1:
            text = 'Tu';
          case 2:
            text = 'We';
          case 3:
            text = 'Th';
          case 4:
            text = 'Fr';
          case 5:
            text = 'Sa';
          case 6:
            text = 'Su';
          default:
            text = '';
        }
        return Text(text);
      },
    ),
  );
}

AxisTitles _bottomAxisTiles2() {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 40,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 0:
            text = 'Air Conditioner';
            break;
          case 1:
            text = 'Smart Light';
            break;
          case 2:
            text = 'Smart TV';
            break;
          case 3:
            text = 'Speaker';
            break;
          default:
            text = '';
        }
        return SizedBox(
          width: 60,
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    ),
  );
}
