import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/painters/bottom_navigation_bar_painter.dart';

class CustomPaintTaskScreen extends StatefulWidget {
  const CustomPaintTaskScreen({super.key});

  @override
  State<CustomPaintTaskScreen> createState() => _CustomPaintTaskScreenState();
}

class _CustomPaintTaskScreenState extends State<CustomPaintTaskScreen> {
  int selectedIndex = 0;

  Widget _bottomButton(IconData iconData, VoidCallback onPressed) {
    return InkWell(onTap: onPressed, child: Icon(iconData, size: 30));
  }

  Widget _buildBottomNavigationBar() {
    List<IconData> icons = [
      Icons.home,
      Icons.bluetooth,
      Icons.train,
      Icons.wifi,
      Icons.person,
    ];

    return SizedBox(
      height: 80,

      child: CustomPaint(
        painter: BottomNavigationBarPainter(selectedIndex: selectedIndex, selectedIcon : icons[selectedIndex]),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: icons.length,
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width / 5,
              child:
                  selectedIndex != index
                      ? _bottomButton(icons[index], () {
                        setState(() {
                          selectedIndex = index;
                        });
                      })
                      : Container(),
            );
          },
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
