import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/navigating_and_passing_data_bw_screens/normal_push_screen.dart';

class NavigationDataPassTaskScreen extends StatefulWidget {
  const NavigationDataPassTaskScreen({super.key});

  @override
  State<NavigationDataPassTaskScreen> createState() =>
      _NavigationDataPassTaskScreenState();
}

class _NavigationDataPassTaskScreenState
    extends State<NavigationDataPassTaskScreen> {
  AppBar _buildHeader() {
    return AppBar(title: Text("Navigation & Passing Data"));
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NormalPushScreen()),
                );
              },
              child: Text("push()"),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                            const NormalPushScreen(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              child: Text("push() with Animation"),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/push_named");
              },
              child: Text("pushNamed()"),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/nested_a_screen");
              },
              child: Text("Nested Routes"),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed("/pass_data_screen", arguments: "Yudiz")
                    .then((value) {
                      SnackBar snackBar = SnackBar(
                        content: Text("Data from child: $value"),
                      );
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
              },
              child: Text("Pass Data"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildHeader(), body: _buildBody());
  }
}
