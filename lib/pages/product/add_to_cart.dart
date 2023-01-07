import 'dart:convert';

import 'package:crunchbox/model/cart.dart';
import 'package:crunchbox/model/response.dart';
import 'package:flutter/material.dart';

class AddToCart extends StatefulWidget {
  final List<CartItem> cartList;

  const AddToCart({Key? key, required this.cartList}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount:
              widget.cartList.isEmpty ? 0 : widget.cartList.length,
          itemBuilder: (context, index) {
            if (widget.cartList.isEmpty) {
              return Center(
                child: Text('Your cart is empty.'),
              );
            }
            var cartItem = widget.cartList[index];
            return ListTile(
              title: Text(''),
            );
          }),
    );
  }
}
