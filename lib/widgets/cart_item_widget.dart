import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/models/cart.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  final VoidCallback onItemZero;
  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onItemZero,
  });

  @override
  State<CartItemWidget> createState() => CartItemWidgetState();
}

class CartItemWidgetState extends State<CartItemWidget> {
  void _incrementCounter() {
    setState(() {
      widget.cartItem.quantity = widget.cartItem.quantity! + 1;
    });
  }

  void decrementCounter() {
    if (widget.cartItem.quantity! < 2) {
      return widget.onItemZero();
    }

    setState(() {
      widget.cartItem.quantity = widget.cartItem.quantity! - 1;
    });
  }

  Widget _buildQuantityInputer() {
    return Container(
      height: 40,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        spacing: 0,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed:
                () => widget.cartItem.inStock! ? _incrementCounter() : null,
            icon: Icon(Icons.add),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          Text(
            "${widget.cartItem.quantity ?? 0}",
            style: TextStyle(fontSize: 18),
          ),
          IconButton(
            onPressed:
                () => widget.cartItem.inStock! ? decrementCounter() : null,
            icon: Icon(Icons.remove),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color:
            widget.cartItem.inStock!
                ? Colors.white
                : const Color.fromARGB(255, 217, 217, 217),
        child: ListTile(
          enabled: widget.cartItem.inStock!,
          leading: CircleAvatar(child: Text("${widget.cartItem.productId}")),
          title: Text(widget.cartItem.productName!),
          subtitle: Text("\$${widget.cartItem.price}"),
          trailing: _buildQuantityInputer(),
        ),
      ),
    );
  }
}
