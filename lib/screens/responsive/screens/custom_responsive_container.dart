import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/widgets/responsive_container.dart';

class CustomResponsiveContainer extends StatefulWidget {
  const CustomResponsiveContainer({super.key});

  @override
  State<CustomResponsiveContainer> createState() =>
      _CustomResponsiveContainerState();
}

class _CustomResponsiveContainerState extends State<CustomResponsiveContainer> {
  Widget _buildBody() {
    return ResponsiveContainer(
      backgroundColor: Colors.pinkAccent,
      child: Center(
        child: Text("Hello", style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }
}
