import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/models/pizza_model.dart';

class PizzaScreen extends StatefulWidget {
  final Pizza pizza;
  const PizzaScreen({super.key, required this.pizza});

  @override
  State<PizzaScreen> createState() => _PizzaScreenState();
}

class _PizzaScreenState extends State<PizzaScreen> {
  @override
  void initState() {
    super.initState();
  }

  AppBar _buildHeader() {
    return AppBar(title: Text("${widget.pizza.name} Pizza"));
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: "Pizza${widget.pizza.name}",
          child: Center(
            child: Image(
              image: AssetImage(widget.pizza.imagePath),
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildHeader(), body: _buildBody());
  }
}
