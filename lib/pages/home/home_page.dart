import 'package:flutter/material.dart';
import 'package:prog_app/pages/cart/cart_page.dart';
import 'package:prog_app/services/cart/cart_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var items = context.watch<CartService>().items;
    var cart = context.watch<CartService>().cart;

    return Scaffold(
      body: ListView(
        children: items
            .map(
              (e) => ListTile(
                title: Text(e.name ?? ''),
                subtitle: Text("R\$ ${e.price ?? ''}"),
                trailing: IconButton(
                  icon: Icon(
                    cart.contains(e) ? Icons.remove_circle : Icons.add_circle,
                  ),
                  onPressed: () {
                    if (!cart.contains(e)) {
                      context.read<CartService>().addToCart(e);
                    } else {
                      context.read<CartService>().removeFromCart(e);
                    }
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
