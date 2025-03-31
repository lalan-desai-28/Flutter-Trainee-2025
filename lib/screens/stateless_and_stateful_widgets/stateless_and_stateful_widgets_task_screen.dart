import 'package:flutter/material.dart';

class StatelessAndStatefulWidgetsTaskScreen extends StatefulWidget {
  const StatelessAndStatefulWidgetsTaskScreen({super.key});

  @override
  State<StatelessAndStatefulWidgetsTaskScreen> createState() =>
      _StatelessAndStatefulWidgetsTaskScreenState();
}

class _StatelessAndStatefulWidgetsTaskScreenState
    extends State<StatelessAndStatefulWidgetsTaskScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint("initState()");
    if (mounted) {
      debugPrint("Mounted!");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("didChangeDependencies()");
  }

  @override
  void didUpdateWidget(
    covariant StatelessAndStatefulWidgetsTaskScreen oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    debugPrint("didUpdateWidget()");
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("deactivate()");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("dispose()");
  }

  bool state = false;

  Widget _buildBody() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Switch value: $state"),
            Switch(
              value: state,
              onChanged: (value) {
                setState(() {
                  state = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build()");
    return _buildBody();
  }
}
