import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/models/cart.dart';
import 'package:flutter_trainee_2025/widgets/cart_item_widget.dart';

class JsonTaskScreen extends StatefulWidget {
  const JsonTaskScreen({super.key});

  @override
  State<JsonTaskScreen> createState() => _JsonTaskScreenState();
}

class _JsonTaskScreenState extends State<JsonTaskScreen> {
  List<CartItem> _cart = [];

  AppBar _buildHeader() {
    return AppBar(title: Text("Your cart"));
  }

  @override
  void initState() {
    super.initState();
    _getJson();
  }

  void _getJson() {
    final String rawJson = """
    [
      {
          "product_id": 101,
          "product_name": "Wireless Headphones",
          "price": 59.99,
          "quantity": 2,
          "in_stock": true
      },
      {
          "product_id": 102,
          "product_name": "Bluetooth Speaker",
          "price": 39.99,
          "quantity": 1,
          "in_stock": false
      },
      {
          "product_id": 103,
          "product_name": "Smartwatch",
          "price": 129.99,
          "quantity": 3,
          "in_stock": true
      },
      {
          "product_id": 104,
          "product_name": "USB-C Charger",
          "price": 19.99,
          "quantity": 5,
          "in_stock": true
      },
      {
          "product_id": 105,
          "product_name": "Noise Cancelling Earbuds",
          "price": 79.99,
          "quantity": 1,
          "in_stock": false
      },
      {
          "product_id": 106,
          "product_name": "Portable Power Bank",
          "price": 24.49,
          "quantity": 2,
          "in_stock": true
      },
      {
          "product_id": 107,
          "product_name": "Gaming Mouse",
          "price": 45.00,
          "quantity": 4,
          "in_stock": true
      },
      {
          "product_id": 108,
          "product_name": "Mechanical Keyboard",
          "price": 89.95,
          "quantity": 1,
          "in_stock": true
      },
      {
          "product_id": 109,
          "product_name": "4K Webcam",
          "price": 74.5,
          "quantity": 1,
          "in_stock": false
      },
      {
          "product_id": 110,
          "product_name": "LED Monitor Light Bar",
          "price": 32.00,
          "quantity": 6,
          "in_stock": true
      }
    ]""";

    List<dynamic> parsedListJson = jsonDecode(rawJson);
    setState(() {
      _cart =
          parsedListJson.map((e) {
            return CartItem.fromJson(e);
          }).toList();
    });
  }

  Widget _buildCartListView() {
    return ListView.builder(
      itemCount: _cart.length,
      itemBuilder: (context, index) {
        return CartItemWidget(
          cartItem: _cart[index],
          onItemZero: () {
            setState(() {
              _cart.removeAt(index);
            });
          },
        );
      },
    );
  }

  Widget _buildBody() {
    return _buildCartListView();
  }

  void _showBuyJsonView() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(jsonEncode(_cart)),
          ),
        );
      },
    );
  }

  FloatingActionButton _buildBuyButton() {
    return FloatingActionButton(
      onPressed: () => _showBuyJsonView(),
      child: Icon(Icons.shopping_cart),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: _buildBody(),
      floatingActionButton: _buildBuyButton(),
    );
  }
}
