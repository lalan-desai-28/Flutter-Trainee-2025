import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/asset_image_fonts_task_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Training")),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            TaskButton(
              title: "AssetImage & Fonts",
              taskScreen: AssetImageFontsTaskScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

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
        title: Text("AssetImage & Fonts"),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
