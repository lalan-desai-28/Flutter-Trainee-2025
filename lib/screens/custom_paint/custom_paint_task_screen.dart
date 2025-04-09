import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/painters/bottom_navigation_bar_painter.dart';

class CustomPaintTaskScreen extends StatefulWidget {
  const CustomPaintTaskScreen({super.key});

  @override
  State<CustomPaintTaskScreen> createState() => _CustomPaintTaskScreenState();
}

class _CustomPaintTaskScreenState extends State<CustomPaintTaskScreen> {
  Widget _bottomButton(IconData iconData, VoidCallback onPressed) {
    return Expanded(
      child: InkWell(onTap: onPressed, child: Icon(iconData, size: 30)),
    );
  }

  Widget _buildBottomNavigationBar() {
    return SizedBox(
      height: 80,
      child: CustomPaint(
        painter: BottomNavigationBarPainter(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bottomButton(Icons.home, () {}),
            _bottomButton(Icons.bluetooth, () {}),
            Spacer(),
            _bottomButton(Icons.wifi, () {}),
            _bottomButton(Icons.person, () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Text("Custom Paint Demo", style: TextStyle(fontSize: 40)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      backgroundColor: const Color.fromARGB(255, 217, 217, 217),
      body: _buildBody(),
    );
  }
}
