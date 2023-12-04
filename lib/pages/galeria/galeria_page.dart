import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class GaleriaPage extends StatefulWidget {
  const GaleriaPage({Key? key}) : super(key: key);

  @override
  _GaleriaPageState createState() => _GaleriaPageState();
}

class _GaleriaPageState extends State<GaleriaPage> {
  List<Product> _cartItems = [];

  List<Product> _products = [
    Product(name: 'Product 1', price: 10.0),
    Product(name: 'Product 2', price: 15.0),
    Product(name: 'Product 3', price: 20.0),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          Product product = _products[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(product.name),
              subtitle: Text('Price: \$${product.price}'),
              trailing: ElevatedButton(
                onPressed: () {
                  _addToCart(product);
                },
                child: const Text('Add to Cart'),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _viewCart();
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void _addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
    });
  }

  void _viewCart() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Shopping Cart'),
          content: _cartItems.isEmpty
              ? const Text('Your cart is empty.')
              : Column(
                  children: _cartItems.map((product) {
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Price: \$${product.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          _removeFromCart(product);
                        },
                      ),
                    );
                  }).toList(),
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cartItems.remove(product);
    });
  }
}
