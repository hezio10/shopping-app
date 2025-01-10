import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    // final total = provider.calculateDiscountedTotal();
    List<Product> allProducts = [];

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
            // child: Icon(),
          ),);
    }
    return Scaffold(
      appBar: AppBar(
       title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                              fontSize: 20, fontWeight: FontWeight.bold
                          ),
                        ),
                        subtitle: Text(
                          finalList[index].description,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(finalList[index].image),
                          backgroundColor: Colors.red.shade100,
                        ),
                        trailing: Text(
                          '${finalList[index].price}MT',
                          style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                  );

                }
            ),
          ),

          Text(
            'Total de pecas: ${CartProvider.count.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
          Text(
            'Total sem desconto: ${provider.calculateTotal().toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
          Text(
            'Percentagem do Desconto: ${provider.calculateDiscount(allProducts)*100}%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
          Text(
            'Valor do Desconto: ${(provider.calculateTotal() * provider.calculateDiscount(allProducts))}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),
          Text(
              'Total a pagar: ${provider.calculateDiscountedTotal(allProducts).toStringAsFixed(2)}MT',
          style: const TextStyle(
          fontSize: 16,
              fontWeight: FontWeight.bold,
          ),),

        ],
      ),
    );
  }
}
