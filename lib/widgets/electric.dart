import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../pages/electric_usage_page.dart';
import '../utils/page_transition.dart';

class ElectricWidget extends StatelessWidget {
  const ElectricWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatMonth = DateFormat("MMM");
    final dateFormatDay = DateFormat("dd");
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onTap: () => Navigator.of(context)
          .push(PageTransition().leftToRight(const ElectricUsagePage())),
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white12, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Electric Usage',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                ),
                const Spacer(),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '27',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' kwh',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '${dateFormatMonth.format(today)} ${dateFormatDay.format(today)}-${dateFormatDay.format(tomorrow)}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w100),
                ),
              ],
            ),
            SvgPicture.asset(
              'assets/electric.svg',
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
