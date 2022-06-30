import 'package:flutter/material.dart';
import '../providers/movies.dart';
import 'package:provider/provider.dart';
import '../providers/movie.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product_detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    Provider.of<Products>(context, listen: false)
        .incrementareNrVizualizari(loadedProduct);

    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: 300,
                width: double.infinity,
                child:
                    Image.network(loadedProduct.imageUrl, fit: BoxFit.cover)),
            SizedBox(
              height: 10,
            ),
            Text(loadedProduct.time.toString() + ' min',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity),
            Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Numar de vizularizari: ' +
                loadedProduct.numar_vizualizari.toString())
          ],
        ),
      ),
    );
  }
}
