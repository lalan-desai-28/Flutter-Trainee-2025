import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/responsive/screens/adaptive_from_screen.dart';
import 'package:flutter_trainee_2025/screens/responsive/screens/custom_responsive_container.dart';
import 'package:flutter_trainee_2025/screens/responsive/screens/multi_device_dashboard_screen.dart';
import 'package:flutter_trainee_2025/screens/responsive/screens/responsive_product_card_screen.dart';
import 'package:flutter_trainee_2025/widgets/task_button_widget.dart';

class ResponsiveTaskScreen extends StatefulWidget {
  const ResponsiveTaskScreen({super.key});

  @override
  State<ResponsiveTaskScreen> createState() => _ResponsiveTaskScreenState();
}

class _ResponsiveTaskScreenState extends State<ResponsiveTaskScreen> {
  AppBar _buildHeader() {
    return AppBar(title: Text("Responsive"));
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          TaskButton(
            title: "Custom Responsive Container",
            push: CustomResponsiveContainer(),
          ),
          TaskButton(
            title: "Responsive Product Card Task",
            push: ResponsiveProductCardScreen(),
          ),
          TaskButton(
            title: "Multi-Device Dashboard",
            push: MultiDeviceDashboardScreen(),
          ),
          TaskButton(title: "Adaptive Form", push: AdaptiveFromScreen()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(), appBar: _buildHeader());
  }
}
