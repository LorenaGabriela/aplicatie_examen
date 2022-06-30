import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id; //final => will get the id
  final String title;
  final String description;
  final int time;
  final String imageUrl;
  int numar_vizualizari;
  // will be changeable

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.imageUrl,
    required this.numar_vizualizari,
  });
}
