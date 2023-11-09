import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TemperatureHumidityWidget extends StatelessWidget {
  const TemperatureHumidityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(' Temperature',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 2),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/temperature.svg',
                  height: 30,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                ),
                const SizedBox(width: 5),
                StreamBuilder(
                  stream: databaseReference.child('Temperature').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value != null) {
                      final temp = snapshot.data!.snapshot.value as double;
                      return Text(
                        '$temp ºC',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator(); // Loading indicator while data is being fetched
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(' Humidity',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary)),
            Row(
              children: [
                Icon(CupertinoIcons.drop,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 5),
                StreamBuilder(
                  stream: databaseReference.child('Humidity').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value != null) {
                      final humidity = snapshot.data!.snapshot.value as int;
                      return Text(
                        '$humidity %',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator(); // Loading indicator while data is being fetched
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
