import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportshopping/screens/details_screen.dart';
import '../components/product_card.dart';
import '../models/product.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isSelected = 0;

  late Future<List<Product>> allProducts;
  late Future<List<Product>> shirtsList;
  late Future<List<Product>> shortsList;

  @override
  void initState() {
    super.initState();
    // Carregar os produtos ao inicializar
    allProducts = fetchProducts('all');
    shirtsList = fetchProducts('camiseta');
    shortsList = fetchProducts('calcoes');
  }

  Future<List<Product>> fetchProducts(String category) async {
    QuerySnapshot querySnapshot;

    if (category == 'all') {
      querySnapshot = await FirebaseFirestore.instance.collection('products').get();
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
    }

    return querySnapshot.docs.map((doc) => Product.fromDocumentSnapshot(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Produtos',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProductCategory(index: 0, name: 'Produtos'),
              _buildProductCategory(index: 1, name: 'Camisetas'),
              _buildProductCategory(index: 2, name: 'Calcoes'),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: isSelected == 0
                ? FutureBuilder<List<Product>>(
              future: allProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  print('damn ${snapshot.error}');
                  return const Center(child: Text('Erro ao carregar produtos'));

                }

                final products = snapshot.data!;
                return _buildProductGrid(products);
              },
            )
                : isSelected == 1
                ? FutureBuilder<List<Product>>(
              future: shirtsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar camisetas'));
                }
                final shirts = snapshot.data!;
                return _buildProductGrid(shirts);
              },
            )
                : FutureBuilder<List<Product>>(
              future: shortsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar calções'));
                }
                final shorts = snapshot.data!;
                return _buildProductGrid(shorts);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildProductCategory({required int index, required String name}) {
    return GestureDetector(
      onTap: () => setState(() => isSelected = index),
      child: Container(
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
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _buildProductGrid(List<Product> products) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 140),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      scrollDirection: Axis.vertical,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(product: product),
            ),
          ),
          child: ProductCard(product: product),
        );
      },
    );
  }
}
