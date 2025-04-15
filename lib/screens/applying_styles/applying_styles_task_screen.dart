import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/models/product.dart';

class ApplyingStylesTaskScreen extends StatefulWidget {
  const ApplyingStylesTaskScreen({super.key});

  @override
  State<ApplyingStylesTaskScreen> createState() =>
      _ApplyingStylesTaskScreenState();
}

class _ApplyingStylesTaskScreenState extends State<ApplyingStylesTaskScreen> {
  final List<Product> _products = [
    Product(
      "Classmates pens",
      imageUrl:
          "https://www.itcportal.com/brands-microsite/images/classmate/classmate07-big.png",
      120.5,
    ),
    Product(
      "Colorbox",
      imageUrl:
          "https://www.itcportal.com/brands-microsite/images/classmate/classmate07-big.png",
      150.00,
    ),
  ];

  bool _addedToCart = false;

  Widget _buildProductListView(List<Product> products) {
    return Theme(
      data: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.black),
            foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 20,
          shadowColor: Colors.pinkAccent,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStatePropertyAll<Color>(Colors.amberAccent),
        ),
      ),
      child: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image(
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(products[index].imageUrl ?? ""),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(200, 120, 120, 120),
                          ),
                          child: Text(
                            products[index].name,
                            style: TextStyle(
                              fontSize: 28,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 6,
                      bottom: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${products[index].price.toString()}",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.shopping_cart_outlined),
                            Switch(
                              value: _addedToCart,
                              onChanged: (value) {
                                setState(() {
                                  _addedToCart = value;
                                });
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Center(child: Text("Buy now")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return _buildProductListView(_products);
  }

  AppBar _buildHeader() {
    return AppBar(title: Text("Applying Styles"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(), appBar: _buildHeader());
  }
}
