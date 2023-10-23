import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_database/firebase_database.dart';

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({
    super.key,
    required this.icon,
    required this.text,
    this.onChanged,
    required this.path,
    this.ontap,
  });

  final String icon, text, path;

  final Function(bool)? onChanged;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white12, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(icon, height: 35),
                StreamBuilder(
                  stream: databaseReference.child(path).onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data?.snapshot.value != null) {
                      final bool ledStatus =
                          snapshot.data!.snapshot.value as bool;
                      return Switch.adaptive(
                        activeColor: Theme.of(context).colorScheme.primary,
                        value: ledStatus,
                        onChanged: (newValue) {
                          databaseReference.child(path).set(newValue);
                        },
                      );
                    } else {
                      return const CircularProgressIndicator(); // Loading indicator while data is being fetched
                    }
                  },
                ),
              ],
            ),
            Hero(
              tag: text,
              child: Text(text,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            )
          ],
        ),
      ),
    );
  }
}
