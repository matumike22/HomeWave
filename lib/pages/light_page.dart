import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../widgets/responsive_widget.dart';

class LightPage extends StatelessWidget {
  const LightPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Smart light'),
      ),
      body: SingleChildScrollView(
        child: ResponsiveWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: databaseReference.child('LED/digital').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data?.snapshot.value != null) {
                    final bool ledStatus =
                        snapshot.data!.snapshot.value as bool;
                    return Column(
                      children: [
                        AnimatedCrossFade(
                          firstChild: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: GlowIcon(
                              CupertinoIcons.lightbulb_fill,
                              size: 120,
                              color: color,
                              glowColor: color,
                              blurRadius: 25,
                            ),
                          ),
                          secondChild: const Padding(
                            padding: EdgeInsets.all(40.0),
                            child: GlowIcon(
                              CupertinoIcons.lightbulb_fill,
                              size: 120,
                              color: Colors.white38,
                              glowColor: Colors.transparent,
                              blurRadius: 0,
                            ),
                          ),
                          crossFadeState: ledStatus
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 300),
                          firstCurve: Curves.easeInOut,
                          secondCurve: Curves.easeInOut,
                        ),
                        const SizedBox(height: 20),
                        SwitchListTile.adaptive(
                          value: ledStatus,
                          activeColor: color,
                          title: const Text('Power',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                          onChanged: (newValue) {
                            databaseReference
                                .child('LED/digital')
                                .set(newValue);
                          },
                        )
                      ],
                    );
                  } else {
                    return const GlowIcon(
                      CupertinoIcons.lightbulb_fill,
                      size: 120,
                      color: Colors.white38,
                      glowColor: Colors.transparent,
                      blurRadius: 0,
                    ); // Loading indicator while data is being fetched
                  }
                },
              ),
              const SizedBox(height: 40),
              const Text('Intensity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              StreamBuilder(
                stream: databaseReference.child('LED/analog').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data?.snapshot.value != null) {
                    final int analogValue =
                        snapshot.data!.snapshot.value as int;
                    return Slider(
                      thumbColor: Colors.white,
                      inactiveColor: Colors.white24,
                      value: analogValue.toDouble(),
                      min: 0,
                      max: 255,
                      onChanged: (newValue) {
                        databaseReference
                            .child('LED/analog')
                            .set(newValue.round());
                      },
                    );
                  } else {
                    return Slider(
                      thumbColor: Colors.white,
                      inactiveColor: Colors.white24,
                      value: 0,
                      min: 0,
                      max: 255,
                      onChanged: (newValue) {},
                    ); // Loading indicator while data is being fetched
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
