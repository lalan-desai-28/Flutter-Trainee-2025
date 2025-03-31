import 'package:flutter/material.dart';

class NestedAScreen extends StatefulWidget {
  const NestedAScreen({super.key});

  @override
  State<NestedAScreen> createState() => _NestedAScreenState();
}

class _NestedAScreenState extends State<NestedAScreen> {
  Widget _buildBody() {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("pop()"),
          ),

          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/nested_b_screen");
            },
            child: Text("Nested B Screen"),
          ),
        ],
      ),
    );
  }

  AppBar _buildHeader() {
    return AppBar(title: Text("A screen"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildHeader(), body: _buildBody());
  }
}
