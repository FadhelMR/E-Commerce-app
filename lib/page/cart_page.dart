import 'package:ecommerceapp/widgets/cart_appbar.dart';
import 'package:ecommerceapp/widgets/cart_bottomnavbar.dart';
import 'package:ecommerceapp/widgets/cart_itemsamples.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Appbar khusus cart
          const CartAppBar(),
          // Isi Halaman
          Container(
            height: 800,
            padding: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 194, 249, 235),
            ),
            child: Column(
              children: [
                // List item
                const CartItemSamples()
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const CartBottomNavbar(),
    );
  }
}
