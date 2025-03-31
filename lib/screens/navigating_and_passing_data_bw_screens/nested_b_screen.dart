import 'package:flutter/material.dart';

class NestedBScreen extends StatefulWidget {
  const NestedBScreen({super.key});

  @override
  State<NestedBScreen> createState() => _NestedBScreenState();
}

class _NestedBScreenState extends State<NestedBScreen> {
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
              Navigator.popUntil(
                context,
                ModalRoute.withName('/navigation_data_pass_bw_screens'),
              );
            },
            child: Text("popUntil() Home Screen"),
          ),
        ],
      ),
    );
  }

  AppBar _buildHeader() {
    return AppBar(title: Text("B screen"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildHeader(), body: _buildBody());
  }
}
