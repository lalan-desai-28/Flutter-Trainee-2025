import 'dart:isolate';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

void heavyComputationTask(SendPort port) {
  final receivePort = ReceivePort();
  port.send(receivePort.sendPort);

  receivePort.listen((dynamic message) async {
    int number = message as int;
    int result = 0;
    for (int i = 1; i <= number; i++) {
      result += i;
    }
    port.send(result);
  });
}

int heavyComputationTask2(int number) {
  int result = 0;
  for (int i = 1; i <= number; i++) {
    result += i;
  }
  return result;
}

class IsolatesTaskScreen extends StatefulWidget {
  const IsolatesTaskScreen({super.key});

  @override
  State<IsolatesTaskScreen> createState() => _IsolatesTaskScreenState();
}

class _IsolatesTaskScreenState extends State<IsolatesTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isIsolateRunning = false;
  int _output = 0;
  Isolate? _isolate;

  late final TextEditingController _numberTextEditController =
      TextEditingController()..text = "987654321";

  Future<void> _startAndListenIsolate() async {
    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
      heavyComputationTask,
      receivePort.sendPort,
      debugName: "Computation Isolate",
    );

    receivePort.listen((dynamic message) {
      if (message is SendPort) {
        SendPort sendPort = message;
        sendPort.send(int.parse(_numberTextEditController.text));
      }
      if (message is int) {
        if (mounted) {
          setState(() {
            _isIsolateRunning = false;
            _output = message;
          });
        }
      }
    });
  }

  void _stopIsolate() {
    if (_isolate == null) return;
    _isolate?.kill(priority: 0);
  }

  @override
  void dispose() {
    super.dispose();
    if (_isIsolateRunning) {
      _stopIsolate();
    }
  }

  Widget _startButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _startAndListenIsolate();
          setState(() {
            _output = 0;
            _isIsolateRunning = true;
          });
        }
      },
      child: Text("Compute Sum"),
    );
  }

  Widget _stopButton() {
    return ElevatedButton(
      onPressed: () {
        _stopIsolate();
        _output = 0;
        setState(() {
          _isIsolateRunning = false;
        });
      },
      child: Text("Stop"),
    );
  }

  Widget _buildInputNumberField() {
    return TextFormField(
      controller: _numberTextEditController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a valid number.";
        }
        return null;
      },
      textAlign: TextAlign.center,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 35),
      decoration: InputDecoration(
        hintText: "Enter number...",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Form(key: _formKey, child: _buildInputNumberField()),
            _isIsolateRunning ? _stopButton() : _startButton(),
            Chip(
              label: Text(
                _isIsolateRunning && _output == 0
                    ? "Computing..."
                    : "Output: $_output",
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildHeader() {
    return AppBar(
      title: Text("Isolates"),
      actions: [
        _isIsolateRunning
            ? Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
            : SizedBox(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(), appBar: _buildHeader());
  }
}
