import 'package:shop/screens/add_movie.dart';

import '../providers/movie.dart';
import '../providers/movies.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widges/product_item.dart';
import '../widges/products_grid.dart';
import '../widges/badge.dart';
import '../providers/cart.dart';
import '../widges/badge.dart';

import '../widges/app_drawer.dart';

//assigning labels to integers

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  int _itemCount = 0;
  Icon customIcon = const Icon(Icons.search);
  bool _search = false;

  Widget customSearchBar = const Text('My Movies');
  final List<Product> loadedProducts = [];
  var _showOnlyFavorites = false;

  String searchKey = '';
  @override
  Widget build(BuildContext context) {
    final _search = TextEditingController();
    void _submitData() {
      setState(() {
        searchKey = _search.text;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _submitData();
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    // setState(() {
                    //   _search = true as TextEditingController;
                    // });
                    customSearchBar = const ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Here ...',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('My Personal Journal');
                  }
                });
              },
              icon: customIcon,
            ),
            Consumer<Cart>(
              builder: (_, cartData, ch) => MyBadge(
                child: ch as Widget,
                value: cartData.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName);
                },
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: ProductsGrid(_showOnlyFavorites));
  }
}
