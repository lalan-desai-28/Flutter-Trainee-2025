import 'package:flutter/material.dart';

class PushNamedScreen extends StatelessWidget {
  const PushNamedScreen({super.key});

  Widget _buildBody()
  {
      return Center(child: Text("Push Named Screen"));
  }

  AppBar _buildHeader()
  {
    return AppBar(title: Text("pushNamed()"),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: _buildBody(),
    );
  }
}