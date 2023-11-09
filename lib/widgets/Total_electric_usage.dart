import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TotalEnergyUsage extends StatefulWidget {
  const TotalEnergyUsage({super.key});

  @override
  State<TotalEnergyUsage> createState() => _TotalEnergyUsageState();
}

class _TotalEnergyUsageState extends State<TotalEnergyUsage> {
  int fan = 0;
  int led = 0;
  int speaker = 0;
  int smartTV = 0;

  late StreamSubscription fanSubscription;
  late StreamSubscription ledSubscription;
  late StreamSubscription speakerSubscription;
  late StreamSubscription smartTVSubscription;

  final fanRef = FirebaseDatabase.instance.ref().child('FAN/digital');
  final ledRef = FirebaseDatabase.instance.ref().child('LED/digital');
  final speakerRef = FirebaseDatabase.instance.ref().child('Speaker/digital');
  final smartTVRef = FirebaseDatabase.instance.ref().child('TV/digital');

  @override
  void initState() {
    super.initState();

    fanSubscription = fanRef.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      bool fanValue = dataSnapshot.value as bool;
      setState(() {
        fan = fanValue ? 7 : 0;
      });
    });

    ledSubscription = ledRef.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      bool ledValue = dataSnapshot.value as bool;
      setState(() {
        led = ledValue ? 3 : 0;
      });
    });
    speakerSubscription = speakerRef.onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      bool speakerValue = dataSnapshot.value as bool;
      setState(() {
        speaker = speakerValue ? 3 : 0;
      });
    });
    smartTVSubscription = smartTVRef.onValue.listen((event) {
      if (mounted) {
        DataSnapshot dataSnapshot = event.snapshot;
        bool smartTVValue = dataSnapshot.value as bool;
        setState(() {
          smartTV = smartTVValue ? 4 : 0;
        });
      }
    });
  }

  @override
  void dispose() {
    fanSubscription.cancel();
    ledSubscription.cancel();
    speakerSubscription.cancel();
    smartTVSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      (led + fan + speaker + smartTV + 10).toString(),
      style: const TextStyle(
          color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),
    );
  }
}
