import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AirConditionerModes extends StatefulWidget {
  const AirConditionerModes({super.key});

  @override
  State<AirConditionerModes> createState() => _AirConditionerModesState();
}

class _AirConditionerModesState extends State<AirConditionerModes> {
  String _mode = 'Cool';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Mode(
          asset: 'assets/cool.svg',
          text: 'Cool',
          mode: _mode,
          ontap: () => setState(() {
            _mode = 'Cool';
          }),
        ),
        Mode(
          asset: 'assets/warm.svg',
          text: 'Warm',
          mode: _mode,
          ontap: () => setState(() {
            _mode = 'Warm';
          }),
        ),
        Mode(
          asset: 'assets/air.svg',
          text: 'Airwave',
          mode: _mode,
          ontap: () => setState(() {
            _mode = 'Airwave';
          }),
        ),
      ],
    );
  }
}

class Mode extends StatelessWidget {
  const Mode(
      {super.key,
      required this.asset,
      required this.text,
      required this.mode,
      this.ontap});

  final String asset, text, mode;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: mode == text
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
            )),
        height: 60,
        width: 90,
        child: Column(
          children: [
            SvgPicture.asset(
              asset,
              height: 20,
              colorFilter: ColorFilter.mode(
                  mode == text
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                  BlendMode.srcIn),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                  color: mode == text
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
