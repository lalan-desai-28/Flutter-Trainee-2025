import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Color backgroundColor;
  final Widget? child;
  const ResponsiveContainer({super.key, required this.backgroundColor, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      color: backgroundColor,
      child: child,
    );
  }
}
