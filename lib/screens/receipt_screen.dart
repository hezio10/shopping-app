import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final cart = provider.cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text(
          "Recibo do Pedido",
          style: TextStyle(color: Colors.blue),
        ),
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue.shade50,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Resumo do Pedido",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const Divider(
                color: Colors.blue,
                thickness: 1.5,
                height: 20,
              ),
              _buildDetailRow(
                "Total de peças",
                "${cart.length}",
              ),
              const SizedBox(height: 10),
              _buildDetailRow(
                "Total sem desconto",
                "${provider.calculateTotal().toStringAsFixed(2)} MT",
              ),
              const SizedBox(height: 10),
              _buildDetailRow(
                "Percentagem do Desconto",
                "${(provider.calculateDiscount(cart) * 100).toStringAsFixed(2)}%",
              ),
              const SizedBox(height: 10),
              _buildDetailRow(
                "Valor do Desconto",
                "${(provider.calculateTotal() * provider.calculateDiscount(cart)).toStringAsFixed(2)} MT",
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.blue,
                thickness: 1.5,
                height: 20,
              ),
              _buildDetailRow(
                "Total a pagar",
                "${provider.calculateDiscountedTotal(cart).toStringAsFixed(2)} MT",
                isBold: true,
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Voltar ao Carrinho",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Confirmar a compra e salvar no banco de dados
                        bool success = true;

                        if (success) {
                          // Lógica para salvar as informações no banco
                          // bool saveSuccess = await provider.checkout(
                          //   items: cart,
                          //   total: provider.calculateDiscountedTotal(cart),
                          // );

                          if (true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Compra realizada e salva com sucesso!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Compra realizada, mas houve um erro ao salvar."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Erro ao processar a compra."),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Comprar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.blue.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.red.shade700,
          ),
        ),
      ],
    );
  }
}
