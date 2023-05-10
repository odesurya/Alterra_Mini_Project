import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/base_model.dart';
import 'package:alterra_mini_project/model/cart_provider.dart';

class AddToCart {
  static void addToCart(BaseModel data, BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    bool contains = cartProvider.itemsOnCart.contains(data);

    if (contains == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('You have added this item to cart before'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      cartProvider.addToCart(data);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(255, 0, 180, 0),
          content: Text('Successfully added to your cart'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
