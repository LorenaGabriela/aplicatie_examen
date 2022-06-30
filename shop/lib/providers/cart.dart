import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'movie.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> items_new = {};

  Map<String, CartItem> get items {
    return {...items_new};
  }

  int get itemCount {
    return items_new.length;
  }

  double get totalAmount {
    double total = 0.0;
    items_new.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (items_new.containsKey(productId)) {
      items_new.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1),
      );
    } else {
      items_new.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    items_new.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!items_new.containsKey(productId)) {
      return;
    }
    if (items_new[productId]!.quantity > 1) {
      items_new.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
    } else {
      items_new.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    items_new = {};
    notifyListeners();
  }
}
