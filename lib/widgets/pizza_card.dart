import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/models/pizza_model.dart';
import 'package:flutter_trainee_2025/screens/animations/pizza_screen.dart';

class PizzaCard extends StatefulWidget {
  final Pizza pizza;
  final bool keepAlive;

  const PizzaCard({super.key, required this.pizza, this.keepAlive = false});

  @override
  State<PizzaCard> createState() => _PizzaCardState();
}

class _PizzaCardState extends State<PizzaCard> with TickerProviderStateMixin {
  late final Animation fadeAnimation;

  late final AnimationController _pizzaAnimationController;

  late final AnimationController _cardAnimationController;

  void startAnimations() {
    _pizzaAnimationController.forward();
    _cardAnimationController.forward();
  }

  @override
  void initState() {
    super.initState();

    _cardAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    fadeAnimation = CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeInCubic,
    );

    _pizzaAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    startAnimations();
  }

  @override
  void dispose() {
    _pizzaAnimationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  Widget _buildCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PizzaScreen(pizza: widget.pizza),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 25),
        height: 220,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 200,

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(width: 1, color: Colors.black),
                ),
                elevation: 20,
                color: Colors.white,

                child: Container(
                  padding: const EdgeInsets.all(30),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.pizza.name,
                        style: TextStyle(
                          fontSize: 35,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.visible,
                        widget.pizza.description,
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              right: -40,
              child: Hero(
                tag: "Pizza${widget.pizza.name}",
                child: AnimatedBuilder(
                  animation: _pizzaAnimationController,
                  child: Image(
                    height: 200,
                    image: AssetImage(widget.pizza.imagePath),
                  ),
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _pizzaAnimationController.value * 2 * math.pi,
                      child: child,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Transform.scale(scale: fadeAnimation.value, child: child);
      },
      child: _buildCard(),
    );
  }
}
