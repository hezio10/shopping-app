import 'package:flutter/material.dart';
import 'package:sportshopping/providers/cart_provider.dart';
import 'package:sportshopping/providers/favorite_provider.dart';
import 'package:sportshopping/screens/favorite_screen.dart';
import 'package:sportshopping/screens/home_page.dart';
import 'package:sportshopping/screens/my_cart.dart';
import 'package:provider/provider.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  int currentIndex = 0;
  List screens = [
    const HomePage(),
    const FavoriteScreen(),
    const MyCart(),
  ];

  @override
  Widget build(BuildContext context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Loja de roupa'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyCart(),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() => currentIndex = value);
          },
          selectedItemColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Favorite',
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
      ),
    ),
    );
  }

