// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/add_movie.dart';
import '../providers/movie.dart';
import '../providers/movies.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int numar_vizualizari;
  var _editedproduct = Product(
      id: '',
      title: '',
      time: 0,
      description: '',
      imageUrl: '',
      numar_vizualizari: 0);
  UserProductItem(this.id, this.title, this.imageUrl, this.numar_vizualizari);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor),
          //_editedproduct.id != '' && _editedproduct.time.compareTo(DateTime.now().subtract(const Duration(days: 31)).toIso8601String(),) == -1 ?
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                          title: Text('Esti sigur?'),
                          content: const Text(
                              'Filmul va fi sters complet din lista.'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text('Nu')),
                            FlatButton(
                                onPressed: () {
                                  Provider.of<Products>(context, listen: false)
                                      .deleteProduct(id);
                                  Navigator.of(ctx).pop(true);
                                },
                                child: Text('Da')),
                          ]));
            },
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
