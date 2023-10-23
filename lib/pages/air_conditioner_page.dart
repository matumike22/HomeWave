import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../widgets/air_conditioner_modes.dart';
import '../widgets/air_conditioner_speed.dart';
import '../widgets/responsive_widget.dart';

class AirConditionerPage extends StatelessWidget {
  const AirConditionerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    final Color color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Air Conditioner'),
      ),
      body: ResponsiveWidget(
        child: Column(children: [
          SleekCircularSlider(
            innerWidget: (value) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${value.round()}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 55,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'ºC',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
            ),
            appearance: CircularSliderAppearance(
                size: 220,
                customColors: CustomSliderColors(progressBarColors: [
                  color,
                  const Color.fromARGB(255, 128, 116, 15)
                ], trackColor: Colors.white54, shadowColor: Colors.transparent),
                customWidths: CustomSliderWidths(
                    progressBarWidth: 15, trackWidth: 5, handlerSize: 10)),
            min: 18,
            max: 30,
            initialValue: 27,
            onChange: (value) {},
          ),
          const AirConditionerModes(),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: databaseReference.child('FAN/digital').onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
                final bool ledStatus = snapshot.data!.snapshot.value as bool;
                return SwitchListTile.adaptive(
                  value: ledStatus,
                  activeColor: color,
                  title: const Text('Power',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  onChanged: (newValue) {
                    databaseReference.child('FAN/digital').set(newValue);
                  },
                );
              } else {
                return SwitchListTile.adaptive(
                  value: false,
                  activeColor: Theme.of(context).colorScheme.primary,
                  title: const Text('Power',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  onChanged: (newValue) {
                    databaseReference.child('FAN/digital').set(newValue);
                  },
                );
              }
            },
          ),
          const SizedBox(height: 20),
          const ListTile(
            title: Text('Speed',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            trailing: AirConditionerSpeed(),
          ),
        ]),
      ),
    );
  }
}
