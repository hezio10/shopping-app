import 'package:flutter/material.dart';
import 'package:sportshopping/models/my_product.dart';
import 'package:sportshopping/screens/details_screen.dart';

import '../components/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Produtos',
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProductCategory(
                index: 0, name: 'Produtos'
              ),
              _buildProductCategory(
                  index: 1, name: 'Camisetas'
              ),
              _buildProductCategory(
                  index: 2, name: 'Calcoes'
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
              child: isSelected == 0
                ? _buildAllProducts()
                  : isSelected == 1
                  ? _buildShirts()
                  : _buildShorts(),
          ),
          // _buildAllProducts(),
        ],
      ),
    );
      
  }

  _buildProductCategory({required int index, required String name}) => GestureDetector(
      onTap: () => setState(() => isSelected = index),
      child:Container(
        width: 100,
        height: 40,
        margin: const EdgeInsets.only(top: 10, right: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected == index ? Colors.blue : Colors.blue.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          name,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      )
  );


  _buildAllProducts() => GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: (100/140),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12
    ),
    scrollDirection: Axis.vertical,
    itemCount: MyProduct.allProducts.length,
    itemBuilder: (context, index) {
      final allProducts = MyProduct.allProducts[index];
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(product: allProducts)
          )
        ),
          child: ProductCard(product: allProducts,)
      );
        
    },
  );

  _buildShirts() => GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100/140),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12
    ),
    scrollDirection: Axis.vertical,
    itemCount: MyProduct.shirtsList.length,
    itemBuilder: (context, index) {
      final shirts = MyProduct.shirtsList[index];
      return ProductCard(product: shirts,);
    },
  );

  _buildShorts() => GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100/140),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12
    ),
    scrollDirection: Axis.vertical,
    itemCount: MyProduct.shortsList.length,
    itemBuilder: (context, index) {
      final shorts = MyProduct.shortsList[index];
      return ProductCard(product: shorts,);
    },
  );
}
