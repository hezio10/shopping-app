import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final int id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
    required this.quantity,
  });

  // Convertendo o produto para um Map<String, dynamic> (para enviar ao Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  // Criando um Produto a partir de um DocumentSnapshot do Firestore
  factory Product.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Product(
      id: data['id'] ?? 0,
      name: data['name'] ?? 'Nome desconhecido',
      category: data['category'] ?? 'Categoria desconhecida',
      image: data['imagePath'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      quantity: data['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'quantity': quantity,
    };
  }

  Future<void> savePurchaseToDatabase(Map<String, dynamic> purchaseData) async {
    // Simulação do salvamento no banco de dados
    print("Simulação: Salvando dados no banco de dados...");
    print(purchaseData);
    await Future.delayed(const Duration(seconds: 1)); // Simula atraso de operação
  }
}
