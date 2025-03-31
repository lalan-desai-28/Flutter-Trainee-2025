import 'package:flutter/material.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
