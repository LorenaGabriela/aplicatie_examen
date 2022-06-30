import 'package:flutter/material.dart';
import '../screens/product_detail.dart';
import 'package:provider/provider.dart';
import '../providers/movie.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return Consumer<Product>(
      builder: (ctx, product, child) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Image.network(product.imageUrl, fit: BoxFit.cover),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(product.title, textAlign: TextAlign.center),
            subtitle: Text(
                'Numar vizualizari: ' + product.numar_vizualizari.toString()),
          ),
        ),
      ),
    );
  }
}
