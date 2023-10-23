import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AirConditionerSpeed extends StatefulWidget {
  const AirConditionerSpeed({super.key});

  @override
  State<AirConditionerSpeed> createState() => _AirConditionerSpeedState();
}

class _AirConditionerSpeedState extends State<AirConditionerSpeed> {
  int _index = 0;
  List<String> speedModes = ['High', 'Med', 'Low'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              if (_index < speedModes.length - 1) {
                setState(() {
                  _index++;
                });
              }
            },
            icon:
                const Icon(CupertinoIcons.chevron_left_circle_fill, size: 30)),
        SizedBox(
          width: 40,
          child: Center(
            child: Text(speedModes[_index],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary)),
          ),
        ),
        IconButton(
            onPressed: () {
              if (_index > 0) {
                setState(() {
                  _index--;
                });
              }
            },
            icon:
                const Icon(CupertinoIcons.chevron_right_circle_fill, size: 30)),
      ],
    );
  }
}
