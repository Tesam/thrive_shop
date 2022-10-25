import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/favorites/favorites.dart';
import 'package:thrive_shop/product/product.dart';
import 'package:thrive_shop/shopping_list/shopping_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> contents = const [
    ShoppingListPage(),
    FavoritesPage(),
    ProductPage(),
  ];

  int index = 0;

  void setIndex(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThriveShop'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.lightColorScheme.primary,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'ThriveShop',
                  style: TextStyle(color: AppColors.lightColorScheme.onPrimary),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                color: AppColors.lightColorScheme.onBackground,
              ),
              title: const Text('Shopping List'),
              onTap: () {
                setIndex(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: AppColors.lightColorScheme.onBackground,
              ),
              title: const Text('Favorites'),
              onTap: () {
                setIndex(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add_box,
                color: AppColors.lightColorScheme.onBackground,
              ),
              title: const Text('Items'),
              onTap: () {
                setIndex(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: contents[index],
    );
  }
}
