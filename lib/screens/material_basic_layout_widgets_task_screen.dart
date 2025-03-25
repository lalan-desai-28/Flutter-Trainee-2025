import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MaterialBasicLayoutWidgetsTaskScreen extends StatefulWidget {
  const MaterialBasicLayoutWidgetsTaskScreen({super.key});

  @override
  State<MaterialBasicLayoutWidgetsTaskScreen> createState() =>
      _MaterialBasicLayoutWidgetsTaskScreenState();
}

class _MaterialBasicLayoutWidgetsTaskScreenState
    extends State<MaterialBasicLayoutWidgetsTaskScreen> {
  String currentPage = "Image";
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: Drawer(
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg",
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Image'),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    setState(() {
                      currentPage = "Image";
                    });
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.stacked_bar_chart),
                title: const Text('Stack'),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    setState(() {
                      currentPage = "Stack";
                    });
                  });
                },
              ),

              ListTile(
                leading: const Icon(Icons.table_rows_sharp),
                title: const Text('Row & Columns'),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    setState(() {
                      currentPage = "Row&Columns";
                    });
                  });
                },
              ),

              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Change Background'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    backgroundColor = Color(math.Random().nextInt(0xffffffff));
                  });
                },
              ),

              ListTile(
                leading: const Icon(Icons.radio_button_checked),
                title: const Text('Snackbar'),
                onTap: () {
                  Navigator.pop(context);
                  const snackBar = SnackBar(
                    content: Text('Wow! A snackbar!!!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Material, Basic & Layout Widgets"),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: switch (currentPage) {
            "Image" => ImagesPage(),
            "Stack" => StackPage(),
            _ => Placeholder(),
          },
        ),
      ),
    );
  }
}

class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  String imagePath = "";

  selectImage() async {
    FilePicker.platform.pickFiles().then((value) {
      setState(() {
        imagePath = value?.files.first.path ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Image from file"),
          TextButton(
            onPressed: () {
              selectImage();
            },
            child: Text("Select Image"),
          ),
          imagePath != "" ? Image.file(File(imagePath)) : Placeholder(),
        ],
      ),
    );
  }
}

class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            color: Colors.red,
            height: screenHeight,
            width: screenWidth,
          ),
          Container(
            color: Colors.green,
            height: screenHeight * 0.6,
            width: screenWidth * 0.6,
          ),
          Container(
            color: Colors.blue,
            height: screenHeight * 0.4,
            width: screenWidth * 0.4,
          ),
        ],
      ),
    );
  }
}

