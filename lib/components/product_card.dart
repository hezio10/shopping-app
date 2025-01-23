import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportshopping/providers/favorite_provider.dart';

import '../models/product.dart';

class ProductCard extends StatefulWidget {
  
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {

    final provider = FavoriteProvider.of(context);

    return Container(
      width: MediaQuery.of(context).size.width /2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey.withOpacity(0.1)
      ),
      child: Column(
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => provider.toggleFavorite(widget.product),
                child: Icon(
                  provider.isExist(widget.product)
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                  color: Colors.blue,
                ),
              )

             ],
          ),
            SizedBox(
              height: 130,
              width: 130,
              child: Image.file(
                File(widget.product.image),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.product.category,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
            Text(
              '${widget.product.price}' 'MT',
              style: const TextStyle(
                fontSize: 18 ,
                fontWeight: FontWeight.bold,
              ),
            )
        ],
      ),
    );
  }
}
