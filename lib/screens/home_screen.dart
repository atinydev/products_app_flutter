import 'package:flutter/material.dart';
import 'package:products_app_flutter/models/models.dart';
import 'package:products_app_flutter/screens/screens.dart';
import 'package:products_app_flutter/services/services.dart';
import 'package:products_app_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = 'Home';

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    );

    if (productsService.isLoading) {
      return const LoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        leading: IconButton(
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
          icon: const Icon(Icons.login_outlined),
        ),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (context, index) {
          final product = productsService.products[index];
          return GestureDetector(
            onTap: () {
              productsService.selectedProduct = product.copy();
              Navigator.pushNamed(context, ProductScreen.routeName);
            },
            child: ProductCard(product: product),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productsService.selectedProduct = Product(
            available: false,
            name: '',
            price: 0,
          );
          Navigator.pushNamed(context, ProductScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
