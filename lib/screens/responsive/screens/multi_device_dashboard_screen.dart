import 'package:flutter/material.dart';

import '../../../models/navigation_item.dart';
import '../../../widgets/sample_screen.dart';

class MultiDeviceDashboardScreen extends StatefulWidget {
  const MultiDeviceDashboardScreen({super.key});

  @override
  State<MultiDeviceDashboardScreen> createState() =>
      _MultiDeviceDashboardScreenState();
}

class _MultiDeviceDashboardScreenState
    extends State<MultiDeviceDashboardScreen> {
  int _selectedIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      label: "Home",
      icon: Icon(Icons.home),
      body: SampleScreen(title: 'Home'),
    ),
    NavigationItem(
      label: "Train",
      icon: Icon(Icons.train),
      body: SampleScreen(title: 'Train'),
    ),
    NavigationItem(
      label: "Account",
      icon: Icon(Icons.person),
      body: SampleScreen(title: 'Account'),
    ),
    NavigationItem(
      label: "Settings",
      icon: Icon(Icons.settings),
      body: SampleScreen(title: 'Settings'),
    ),
  ];

  Drawer _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Container(color: Colors.pink)),
          Expanded(
            child: ListView.builder(
              itemCount: _navigationItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    Navigator.of(context).pop();
                  },
                  title: Text(_navigationItems[index].label),
                  leading: _navigationItems[index].icon,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      unselectedItemColor: Colors.grey,
      items:
          _navigationItems
              .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
              .toList(),
    );
  }

  Widget _buildBody() {
    return _navigationItems[_selectedIndex].body;
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text(_navigationItems[_selectedIndex].label));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile View
          return Scaffold(
            bottomNavigationBar: _buildBottomNavigationBar(),
            body: _buildBody(),
            appBar: _buildAppBar(),
          );
        } else {
          // Tablet, Desktop View
          return Scaffold(
            drawer: _buildDrawer(),
            appBar: _buildAppBar(),
            body: _buildBody(),
          );
        }
      },
    );
  }
}



