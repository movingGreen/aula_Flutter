import 'package:flutter/material.dart';
import 'package:prog_app/services/cart/cart_service.dart';
import 'package:prog_app/services/pedidos/pedidos_service.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var pedidosService = context.watch<PedidosService>();
    return Consumer<CartService>(builder: (context, cartServices, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Seu carrinho (${cartServices.cart.length})"),
        ),
        body: ListView.builder(
          itemCount: cartServices.cart.length,
          itemBuilder: (context, index) {
            var item = cartServices.cart[index];

            return ListTile(
              title: Text(item.name ?? ''),
              subtitle: Text("R\$ " + (item.price ?? '')),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {
                  context.read<CartService>().removeFromCart(item);
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            cartServices.cart.forEach((item) {
              pedidosService.addToPedidos(item);
            });

            // Clear the cart
            cartServices.clearCart();

            // Refresh the screen
            setState(() {});
          },
          child: Icon(Icons.check),
        ),
      );
    });
  }
}
