import 'package:flutter/material.dart';

class NormalPushScreen extends StatefulWidget {
  const NormalPushScreen({super.key});

  @override
  State<NormalPushScreen> createState() => _NormalPushScreenState();
}

class _NormalPushScreenState extends State<NormalPushScreen> {
  Widget _buildBody() {
    return Center(child: Text("Normal Push"));
  }

  AppBar _buildHeader() {
    return AppBar(title: Text("push()"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: _buildBody(),
    );
  }
}
