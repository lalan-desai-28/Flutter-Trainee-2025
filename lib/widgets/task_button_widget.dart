import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  final String title;
  final Widget taskScreen;
  const TaskButton({super.key, required this.title, required this.taskScreen});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => taskScreen));
        },
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
