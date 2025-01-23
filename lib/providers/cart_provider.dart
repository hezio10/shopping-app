import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;
  static int count = 0;
  static int countCalcoes = 0;
  static int countCamisetas = 0;

  void toggleProduct(Product product) {
    if (_cart.contains(product)) {
      for (Product element in _cart) {
        element.quantity++;
      }
    } else {
      _cart.add(product);
    }

    count ++;
    if(product.category == 'camiseta') {
      countCamisetas++;
    } else {
      countCalcoes++;
    }
    notifyListeners();
  }

  incrementQuantity(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  decrementQuantity(int index) {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
    } else {
      _cart.removeAt(index);
    }
    notifyListeners();
  }

  double calculateTotal() {
    double total = 0.0;
    for (var product in _cart) {
      total += product.price * product.quantity;
    }
    return total;
  }

  bool allProductsAdded(List<Product> allProducts) {
    for (var product in allProducts) {
      if (!_cart.contains(product.category)) {
        return false;
      }
    }
    return true;
  }

  double calculateDiscount(List<Product> allProducts) {
    double discount = 0.0;
   if (count >= 6) {
      discount = 0.15;
    }else if (allProductsAdded(allProducts)) {
      discount = 0.05;
    }

    return discount;
  }
  double calculateDiscountedTotal(List<Product> allProducts) {
    double total = calculateTotal();
    double discount = calculateDiscount(allProducts);

    return total - (total * discount);
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(context, listen: listen);
  }

  // Future<bool> checkout() async {
  //   try {
  //     // Simular salvar a compra no banco de dados.
  //     final purchaseData = {
  //       "items": _cart.map((product) => product.toJson()).toList(),
  //       "total": calculateDiscountedTotal(_cart),
  //       "timestamp": DateTime.now().toIso8601String(),
  //     };
  //     await savePurchaseToDatabase(purchaseData);
  //
  //     // Limpar o carrinho.
  //     _cart.clear();
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     print("Erro ao processar checkout: $e");
  //     return false;
  //   }
  // }

  // Future<bool> savePurchase({
  //   required List<Item> items,
  //   required double total,
  // }) async {
  //   try {
  //
  //     final purchaseData = {
  //       'items': items.map((item) => item.toJson()).toList(),
  //       'total': total,
  //       'timestamp': DateTime.now().toString(),
  //     };
  //
  //     // Simulação de envio para o banco
  //     await database.save('purchases', purchaseData);
  //     return true;
  //   } catch (e) {
  //     print("Erro ao salvar compra: $e");
  //     return false;
  //   }
  // }

}
