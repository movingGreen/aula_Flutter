import 'package:flutter/material.dart';
import 'package:prog_app/models/cart/cart_item.dart';

class PedidosService with ChangeNotifier {
  final List<CartItem> _pedidos = [];

  List<CartItem> get pedidos => _pedidos;

  void addToPedidos(CartItem item) {
    _pedidos.add(item);
    notifyListeners();
  }

  void removeFromPedidos(CartItem item) {
    _pedidos.remove(item);
    notifyListeners();
  }
}
