import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/utils/shared_preferences.dart';

import '../../models/cart.dart';
import '../../widgets/cart_item_widget.dart';

class JsonPlusSharedPreferencesTaskScreen extends StatefulWidget {
  const JsonPlusSharedPreferencesTaskScreen({super.key});

  @override
  State<JsonPlusSharedPreferencesTaskScreen> createState() =>
      _JsonPlusSharedPreferencesTaskScreenState();
}

class _JsonPlusSharedPreferencesTaskScreenState
    extends State<JsonPlusSharedPreferencesTaskScreen> {
  List<CartItem> _cart = [];

  final String defaultJson = """
    [
      {
          "product_id": 101,
          "product_name": "Wireless Headphones",
          "price": 59.99,
          "quantity": 1,
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
          "quantity": 1,
          "in_stock": true
      },
      {
          "product_id": 104,
          "product_name": "USB-C Charger",
          "price": 19.99,
          "quantity": 1,
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
          "quantity": 1,
          "in_stock": true
      },
      {
          "product_id": 107,
          "product_name": "Gaming Mouse",
          "price": 45.00,
          "quantity": 1,
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
          "quantity": 1,
          "in_stock": true
      }
    ]""";

  Future<void> _setJson(String rawJson) async {
    final pref = await AppSharedPreferences().sharedPref;
    await pref.setString("cart_json", rawJson);
  }

  Future<void> _resetJson() async {
    _setJson(defaultJson);
    _getJson();
  }

  Future<void> _getJson() async {
    final pref = await AppSharedPreferences().sharedPref;
    final prefJson = pref.getString("cart_json");

    List<dynamic> parsedListJson = jsonDecode(prefJson ?? defaultJson);
    setState(() {
      _cart =
          parsedListJson.map((e) {
            return CartItem.fromJson(e);
          }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getJson();
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
              _setJson(jsonEncode(_cart));
            });
          },
          onItemAddOrRemove: () {
            _setJson(jsonEncode(_cart));
          },
        );
      },
    );
  }

  List<Widget> _buildActionButtons() {
    return [
      IconButton(
        onPressed: () => _resetJson(),
        icon: Icon(Icons.restart_alt),
      ),
      IconButton(
        onPressed: () => _showBuyJsonView(),
        icon: Icon(Icons.shopping_cart),
      ),
    ];
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

  Widget _buildBody() {
    return _buildCartListView();
  }

  AppBar _buildAppbar() {
    return AppBar(actions: _buildActionButtons());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppbar(),
    );
  }
}
