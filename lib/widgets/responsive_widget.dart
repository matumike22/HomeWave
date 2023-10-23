import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget(
      {super.key,
      required this.child,
      this.isExtended,
      this.verticalPadding,
      this.horizontalPadding,
      this.maxWidth});
  final Widget child;
  final bool? isExtended;
  final double? verticalPadding, maxWidth, horizontalPadding;

  @override
  Widget build(BuildContext context) {
    if (isExtended == true) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 20,
            vertical: verticalPadding ?? 20),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth ?? 900),
            child: child,
          ),
        ),
      );
    }
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 20, vertical: verticalPadding ?? 20),
      child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? 900), child: child),
    ));
  }
}
