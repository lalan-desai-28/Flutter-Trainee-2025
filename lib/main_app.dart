import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/animations/animation_task_screen.dart';
import 'package:flutter_trainee_2025/screens/app_lifecycle/app_lifecycle_task_screen.dart';
import 'package:flutter_trainee_2025/screens/applying_styles/applying_styles_task_screen.dart';
import 'package:flutter_trainee_2025/screens/asset_images_and_fonts/asset_image_fonts_task_screen.dart';
import 'package:flutter_trainee_2025/screens/custom_paint/custom_paint_task_screen.dart';
import 'package:flutter_trainee_2025/screens/dialog_tabbar_navigationbar_custom_widgets/dialog_tabbar_navigationbar_csutom_widget_task_screen.dart';
import 'package:flutter_trainee_2025/screens/getx/getx_task_screen.dart';
import 'package:flutter_trainee_2025/screens/hive_plus_sqlite/hive_plus_sqlite_task_screen.dart';
import 'package:flutter_trainee_2025/screens/isolates/isolates_task_screen.dart';
import 'package:flutter_trainee_2025/screens/json/json_task_screen.dart';
import 'package:flutter_trainee_2025/screens/json_plus_shared_preferences/json_plus_shared_preferences_task_screen.dart';
import 'package:flutter_trainee_2025/screens/listview_and_gridview/listview_gridview_task_screen.dart';
import 'package:flutter_trainee_2025/screens/main_screen.dart';
import 'package:flutter_trainee_2025/screens/material_basic_and_layout_widgets/material_basic_layout_widgets_task_screen.dart';
import 'package:flutter_trainee_2025/screens/navigating_and_passing_data_bw_screens/navigation_data_pass_task_screen.dart';
import 'package:flutter_trainee_2025/screens/navigating_and_passing_data_bw_screens/nested_a_screen.dart';
import 'package:flutter_trainee_2025/screens/navigating_and_passing_data_bw_screens/nested_b_screen.dart';
import 'package:flutter_trainee_2025/screens/navigating_and_passing_data_bw_screens/pass_data_screen.dart';
import 'package:flutter_trainee_2025/screens/navigating_and_passing_data_bw_screens/push_named_screen.dart';
import 'package:flutter_trainee_2025/screens/responsive/responsive_task_screen.dart';
import 'package:flutter_trainee_2025/screens/slivers/slivers_task_screen.dart';
import 'package:flutter_trainee_2025/screens/stateless_and_stateful_widgets/stateless_and_stateful_widgets_task_screen.dart';
import 'package:flutter_trainee_2025/screens/streams/streams_task_screen.dart';
import 'package:flutter_trainee_2025/screens/textfields_and_forms/textfields_forms_task_screen.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Map<String, WidgetBuilder> _getRoutes(BuildContext context) {
    return {
      "/": (context) => const MainScreen(),
      "/assetimages_and_fonts": (context) => const AssetImageFontsTaskScreen(),
      "/material_basic_layout_widgets":
          (context) => const MaterialBasicLayoutWidgetsTaskScreen(),
      "/dialog_tabbar_navigationbar_custom_widget":
          (context) => const DialogTabbarNavigationbarCsutomWidgetTaskScreen(),
      "/textfields_forms": (context) => const TextfieldsFormsTaskScreen(),
      "/listview_and_gridview":
          (context) => const ListviewAndGridviewTaskScreen(),
      "/stateless_stateful_widgets":
          (context) => const StatelessAndStatefulWidgetsTaskScreen(),
      "/navigation_data_pass_bw_screens":
          (context) => const NavigationDataPassTaskScreen(),
      "/push_named": (context) => const PushNamedScreen(),
      "/nested_a_screen": (context) => const NestedAScreen(),
      "/nested_b_screen": (context) => const NestedBScreen(),
      "/pass_data_screen": (context) => const PassDataScreen(),
      "/applying_styles_screen": (context) => const ApplyingStylesTaskScreen(),
      "/streams_screen": (context) => const StreamsTaskScreen(),
      "/isolates_screen": (context) => const IsolatesTaskScreen(),
      "/animation_screen": (context) => const AnimationTaskScreen(),
      "/json_screen": (context) => const JsonTaskScreen(),
      "/custom_paint_screen": (context) => const CustomPaintTaskScreen(),
      "/slivers_screen": (context) => const SliversTaskScreen(),
      "/app_lifecycle_screen": (context) => const AppLifecycleTaskScreen(),
      "/json_plus_shared_preferences":
          (context) => const JsonPlusSharedPreferencesTaskScreen(),
      "/responsive_screen": (context) => const ResponsiveTaskScreen(),
      "/hive_plus_sqlite_screen": (context) => const HivePlusSqliteTaskScreen(),
      "/getx_screen": (context) => const GetxTaskScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Trainee 2025',
      routes: _getRoutes(context),
    );
  }
}
