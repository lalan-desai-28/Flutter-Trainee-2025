import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/animations/animation_task_screen.dart';
import 'package:flutter_trainee_2025/widgets/task_button_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Training")),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TaskButton(
                title: "AssetImage & Fonts",
                routePath: "/assetimages_and_fonts",
              ),

              TaskButton(
                title: "Material, Basic & Layout Widgets",
                routePath: "/material_basic_layout_widgets",
              ),

              TaskButton(
                title: "Dialog, Tabbar, Navigationbar & Custom Widget",
                routePath: "/dialog_tabbar_navigationbar_custom_widget",
              ),

              TaskButton(
                title: "TextFields & Forms",
                routePath: "/textfields_forms",
              ),

              TaskButton(
                title: "Listview & Gridview",
                routePath: "/listview_and_gridview",
              ),

              TaskButton(
                title: "Stateless & Stateful Widgets",
                routePath: "/stateless_stateful_widgets",
              ),

              TaskButton(
                title: "Navigating & Passing Data BW Screens",
                routePath: "/navigation_data_pass_bw_screens",
              ),

              TaskButton(
                title: "Applying Styles to Widgets",
                routePath: "/applying_styles_screen",
              ),

              TaskButton(title: "Streams", routePath: "/streams_screen"),
              TaskButton(title: "Isolates", routePath: "/isolates_screen"),
              TaskButton(title: "Animations", push: AnimationTaskScreen()),
              TaskButton(
                title: "Json Serialization and Deserialization",
                routePath: '/json_screen',
              ),
              TaskButton(
                title: "Custom Paint",
                routePath: '/custom_paint_screen',
              ),
              TaskButton(
                title: "Slivers",
                routePath: '/slivers_screen',
              ),
              TaskButton(
                title: "App Lifecycle",
                routePath: '/app_lifecycle_screen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
