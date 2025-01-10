import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportshopping/components/available_size.dart';
import 'package:sportshopping/providers/cart_provider.dart';

import '../models/product.dart';
import 'my_cart.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 36,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade100,
                ),
                child: Image.asset(product.image, fit: BoxFit.cover,),
              )
            ],
          ),
          const SizedBox(height: 36,),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)
              )
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        product.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${product.price}' 'MT',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Text(
                  product.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tamanhos disponiveis',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                ),
                const SizedBox(height: 8.0,),
                const Row(
                  children: [
                    AvailableSize(size: "S"),
                    AvailableSize(size: "M"),
                    AvailableSize(size: "L")
                  ],
                ),
                const SizedBox(height: 8.0,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cores disponiveis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
                const SizedBox(height: 8.0,),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue,
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.red,
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.amber,
                    )
                  ],
                ),
              ],
            ),
          )
      ],),
      bottomSheet: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 10,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )
          ),
          child: Row(
            children: [
              Text(
                '${product.price}' 'MT',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              const SizedBox(width: 10,),
              ElevatedButton.icon(
                  onPressed: () {
                    provider.toggleProduct(product);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyCart(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Add to Cart'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
