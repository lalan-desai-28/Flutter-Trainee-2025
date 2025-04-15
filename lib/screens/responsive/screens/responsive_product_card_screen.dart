import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/constants/image_constants.dart';
import 'package:flutter_trainee_2025/models/product.dart';
import 'package:flutter_trainee_2025/widgets/responsive_product_card.dart';

class ResponsiveProductCardScreen extends StatefulWidget {
  const ResponsiveProductCardScreen({super.key});

  @override
  State<ResponsiveProductCardScreen> createState() =>
      _ResponsiveProductCardScreenState();
}

class _ResponsiveProductCardScreenState
    extends State<ResponsiveProductCardScreen> {
  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Products"),
            ResponsiveProductCard(
              product: Product(
                "Logitech Pebble Mouse 2 M350s",
        
                1395.00,
                assetPath: ImageConstants.wirelessMouse,
                description:
                    "Logitech Pebble Mouse 2 M350s Slim Bluetooth Wireless Mouse, Portable, Lightweight, Customisable Button, Quiet Clicks, Easy-Switch for Windows, macOS, iPadOS, Android, Chrome OS - Tonal Graphite",
              ),
            ),
            ResponsiveProductCard(
              product: Product(
                "Keyboard Logitech Wireless Pebble Keys 2 K380s Graphite",
                2995.00,
                assetPath: ImageConstants.wirelessKeyboard,
                description:
                "Logitech Pebble Keys 2 K380s, Multi-Device Bluetooth Wireless Keyboard with Customisable Shortcuts, Slim and Portable, Easy-Switch for Windows, macOS, iPadOS, Android, Chrome OS - Tonal Graphite",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }
}
