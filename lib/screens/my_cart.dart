import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sportshopping/screens/receipt_screen.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;

    _buildProductQuantity(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            icon == Icons.add
                ? provider.incrementQuantity(index)
                : provider.decrementQuantity(index);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.shade100,
          ),
          child: Icon(
            icon,
            color: Colors.red,
          ),
        ),
      );
    }

    if (finalList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Seu carrinho está vazio!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Text(
                  "Cart",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: finalList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      finalList[index].name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      finalList[index].description,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(File(finalList[index].image)),
                      backgroundColor: Colors.red.shade100,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildProductQuantity(Icons.remove, index),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            finalList[index].quantity.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildProductQuantity(Icons.add, index),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navega para a tela de recibo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReceiptScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Ver Recibo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
          // Text(
          //   'Total de peças: ${CartProvider.count}',
          //   style: const TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // Text(
          //   'Total sem desconto: ${provider.calculateTotal().toStringAsFixed(2)}',
          //   style: const TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // Text(
          //   'Percentagem do Desconto: ${(provider.calculateDiscount(finalList) * 100).toStringAsFixed(2)}%',
          //   style: const TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // Text(
          //   'Valor do Desconto: ${(provider.calculateTotal() * provider.calculateDiscount(finalList)).toStringAsFixed(2)}MT',
          //   style: const TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // Text(
          //   'Total a pagar: ${provider.calculateDiscountedTotal(finalList).toStringAsFixed(2)}MT',
          //   style: const TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),

    );
  }
}
