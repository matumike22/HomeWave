import 'dart:math';

import 'package:flutter/material.dart';

class DoorAnimation extends StatefulWidget {
  const DoorAnimation({super.key, required this.onTap, required this.isOpen});

  final Future<void> Function() onTap;
  final bool isOpen;

  @override
  State<DoorAnimation> createState() => _DoorAnimationState();
}

class _DoorAnimationState extends State<DoorAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isDoorOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.isOpen) {
      _controller.forward();
      setState(() {
        isDoorOpen = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    const openAngle = pi / 4 + 0.2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              height: 400,
              width: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 3),
              ),
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final angle = 0 + (openAngle * _controller.value);
                    return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle),
                        alignment: Alignment
                            .centerRight, // Set the rotation origin to the left end
                        origin: const Offset(0.0, 0.5),
                        child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.centerLeft,
                            color: color,
                            padding: const EdgeInsets.all(10),
                            child: const Icon(Icons.circle_outlined,
                                color: Colors.black)));
                  }),
            );
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            try {
              await widget.onTap();
              if (isDoorOpen) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
              setState(() {
                isDoorOpen = !isDoorOpen;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Something Went Wrong')));
            }
          },
          child: Text(
            isDoorOpen ? 'Close Door' : 'Open Door',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
