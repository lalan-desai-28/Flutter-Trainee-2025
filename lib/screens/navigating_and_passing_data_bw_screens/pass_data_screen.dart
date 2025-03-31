import 'package:flutter/material.dart';

class PassDataScreen extends StatefulWidget {
  const PassDataScreen({super.key});

  @override
  State<PassDataScreen> createState() => _PassDataScreenState();
}

class _PassDataScreenState extends State<PassDataScreen> {
  late String parentData;

  Widget _buildBody() {
    parentData = ModalRoute.of(context)!.settings.arguments as String;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Data from parent: $parentData"),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop("Solutions");
            },
            child: Text("Pass data to parent"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }
}
