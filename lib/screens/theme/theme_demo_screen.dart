import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/theme/models/themes_enum.dart';
import 'package:flutter_trainee_2025/screens/theme/theme_controller.dart';
import 'package:flutter_trainee_2025/screens/theme/themes/themes_helper.dart';
import 'package:get/get.dart';

class ThemeDemoScreen extends StatefulWidget {
  const ThemeDemoScreen({super.key});

  @override
  State<ThemeDemoScreen> createState() => _ThemeDemoScreenState();
}

class _ThemeDemoScreenState extends State<ThemeDemoScreen> {
  final ThemeController _controller = Get.put(ThemeController());

  AppBar _buildHeader() {
    return AppBar(
      title: Text("Theme"),
      actionsPadding: EdgeInsets.only(right: 5),
      actions: [
        Text("Dark theme:"),
        Obx(
          () => Switch(
            value: _controller.isDarkTheme.value,
            onChanged: (value) {
              _controller.isDarkTheme.value = value;
              Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
            },
          ),
        ),
      ],
    );
  }

  Widget _themeButton(Color backgroundColor, String label, Themes theme) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
      onPressed: () {
        Get.changeTheme(ThemesHelper.getTheme(theme));
      },
      child: SizedBox(
        width: double.infinity,
        child: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(onPressed: () {}, child: Icon(Icons.add));
  }

  Widget _buildBody() {
    return Theme(
      data: ThemeData(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _themeButton(Colors.blue, "Default theme", Themes.defaultTheme),
            _themeButton(Colors.amber, "Amber theme", Themes.amber),
            _themeButton(Colors.pink, "Pink theme", Themes.pink),
            _themeButton(Colors.red, "Red theme", Themes.red),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: _buildBody(),
      floatingActionButton: _floatingActionButton(),
    );
  }
}
