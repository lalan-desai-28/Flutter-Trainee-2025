import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/models/product.dart';

class ResponsiveProductCard extends StatefulWidget {
  final Product product;

  const ResponsiveProductCard({super.key, required this.product});

  @override
  State<ResponsiveProductCard> createState() => _ResponsiveProductCardState();
}

class _ResponsiveProductCardState extends State<ResponsiveProductCard> {

  Widget _buildWideBody() {
    return  Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.4,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.4,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(widget.product.assetPath ?? ""),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                widget.product.description ?? "",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "₹${widget.product.price}",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactBody() {
    return  Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(widget.product.assetPath ?? ""),
          ),
        ),
        Text(widget.product.name, style: TextStyle(fontSize: 20)),
        Text(
          "₹${widget.product.price}",
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildWideBody();
              } else {
                return _buildCompactBody();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
