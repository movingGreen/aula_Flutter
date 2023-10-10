import 'package:flutter/material.dart';
import 'package:prog_app/models/cart/cart_item.dart';

class CartService with ChangeNotifier {
  final List<CartItem> _items = getItems();
  final List<CartItem> _cart = [];

  List<CartItem> get items => _items;

  List<CartItem> get cart => _cart;

  void addToCart(CartItem item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }
}
