import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/asset_image_fonts_task_screen.dart';
import 'package:flutter_trainee_2025/screens/cupertino_task_screen.dart';
import 'package:flutter_trainee_2025/screens/dialog_tabbar_navigationbar_csutom_widget_task_screen.dart';
import 'package:flutter_trainee_2025/screens/material_basic_layout_widgets_task_screen.dart';
import 'package:flutter_trainee_2025/widgets/task_button_widget.dart';

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
            TaskButton(
              title: "Material, Basic & Layout Widgets",
              taskScreen: MaterialBasicLayoutWidgetsTaskScreen(),
            ),
            TaskButton(title: "Cupertino", taskScreen: CupertinoTaskScreen()),
            TaskButton(
              title: "Dialog, Tabbar, Navigationbar, Csutom Widget",
              taskScreen: DialogTabbarNavigationbarCsutomWidgetTaskScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
