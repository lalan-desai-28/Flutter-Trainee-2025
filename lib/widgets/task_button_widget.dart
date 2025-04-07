import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  final String title;
  final String? routePath;
  final Widget? push;

  const TaskButton({super.key, required this.title, this.routePath, this.push});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          if (push != null) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                pageBuilder: (context, animation, secondaryAnimation) => push!,
              ),
            );
          }

          if (routePath != null) {
            Navigator.of(context).pushNamed(routePath!);
          }
        },
        title: Text(title),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
