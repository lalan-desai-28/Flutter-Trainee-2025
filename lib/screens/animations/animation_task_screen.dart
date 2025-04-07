import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/constants/image_constants.dart';
import 'package:flutter_trainee_2025/models/pizza_model.dart';
import 'package:flutter_trainee_2025/widgets/pizza_card.dart';

class AnimationTaskScreen extends StatefulWidget {
  const AnimationTaskScreen({super.key});

  @override
  State<AnimationTaskScreen> createState() => _AnimationTaskScreenState();
}

class _AnimationTaskScreenState extends State<AnimationTaskScreen> {
  Widget _buildBody() {
    return Center(child: _buildListview());
  }

  final List<Pizza> _pizzaLists = [
    Pizza(
      "Capricciosa",
      "This is the Capricciosa.",
      ImageConstants.capricciosaPizza,
    ),
    Pizza("Hawaiian", "This is the Hawaiian.", ImageConstants.hawaiianPizza),
    Pizza(
      "Margherita",
      "This is the desciption.",
      ImageConstants.margheritaPizza,
    ),
    Pizza("Marinara", "This is the Marinara.", ImageConstants.marinaraPizza),
    Pizza("Mexican", "This is the Mexican.", ImageConstants.mexicanPizza),

    Pizza("Mushrrom", "This is the Mushrrom.", ImageConstants.mushroomPizza),

    Pizza("Pepperoni", "This is the Pepperoni.", ImageConstants.pepperoniPizza),

    Pizza("Seafood", "This is the Seafood.", ImageConstants.seafoodPizza),

    Pizza(
      "Vegetariana",
      "This is the Vegetariana.",
      ImageConstants.vegetarianaPizza,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildListview() {
    return ListView.builder(
      cacheExtent: 0,
      itemCount: _pizzaLists.length,
      itemBuilder: (context, index) {
        return PizzaCard(pizza: _pizzaLists[index]);
      },
    );
  }

  AppBar _buiildHeader() {
    return AppBar(
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text("The Pizza Mania"),
      leading: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(), appBar: _buiildHeader());
  }
}
