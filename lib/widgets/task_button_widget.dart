import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  final String title;
  final String routePath;
  const TaskButton({super.key, required this.title, required this.routePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(routePath);
        },
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
