import 'package:flutter/material.dart';
import '../providers/movie.dart';
import './product_item.dart';
import 'package:provider/provider.dart';
import '../providers/movies.dart';
import 'package:provider/src/change_notifier_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.items : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 1.3,
        crossAxisSpacing: 0,
        mainAxisSpacing: 10,
      ),
    );
  }
}
