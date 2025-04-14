import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppLifecycleTaskScreen extends StatefulWidget {
  const AppLifecycleTaskScreen({super.key});

  @override
  State<AppLifecycleTaskScreen> createState() => _AppLifecycleTaskScreenState();
}

class _AppLifecycleTaskScreenState extends State<AppLifecycleTaskScreen> {
  late final AppLifecycleListener _listener;
  late AppLifecycleState? _state;

  late Timer _timer;
  int time = 0;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (mounted) {
        setState(() {
          time = time + 1;
        });
      }
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();

    _startTimer();

    _state = SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      onResume: () {
        _startTimer();
      },
      onInactive: () {
        _stopTimer();
      },
    );

  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    return Center(child: Text("Timer: $time", style: TextStyle(fontSize: 40)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }
}
