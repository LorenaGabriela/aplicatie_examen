import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail.dart';
import 'providers/movies.dart';
import 'package:provider/provider.dart';
import './providers/cart.dart';
import './screens/user_products_screen.dart';
import 'screens/add_movie.dart';
import './providers/movie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
          title: 'Movies',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (c) => EditProductScreen(),
          }),
    );
  }
}
