import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/door_animation.dart';
import '../widgets/responsive_widget.dart';

class DoorPage extends StatelessWidget {
  const DoorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Front Door'),
      ),
      body: SingleChildScrollView(
        child: ResponsiveWidget(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: databaseReference.child('door/digital').onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
                  final bool doorStatus = snapshot.data!.snapshot.value as bool;
                  return Center(
                    child: DoorAnimation(
                        onTap: () async {
                          await databaseReference
                              .child('door/digital')
                              .set(!doorStatus);
                        },
                        isOpen: doorStatus),
                  );
                } else {
                  return const CircularProgressIndicator(); // Loading indicator while data is being fetched
                }
              },
            ),
          ],
        )),
      ),
    );
  }
}
