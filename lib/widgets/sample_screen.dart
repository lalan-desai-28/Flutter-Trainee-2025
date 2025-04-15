import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  final String title;

  const SampleScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}
