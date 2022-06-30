import 'package:flutter/cupertino.dart';
import 'movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  //daca nu merge pune in loc de items_new -> _items
  List<Product> items_new = [
    Product(
        id: 'p1',
        title: 'Ratatouille',
        description:
            'Remy este un tanar soarece al carui vis este sa devina maestru bucatar. El nu e descurajat nici de piedicile pe care i le pune familia, nici de faptul ca gastronomia este o profesie care uraste soarecii prin excelenta.',
        time: 90,
        imageUrl:
            'https://lumiere-a.akamaihd.net/v1/images/p_ratatouille_19736_0814231f.jpeg',
        numar_vizualizari: 0),
    Product(
        id: 'p2',
        title: 'Tangled',
        description:
            'Frumoasa Rapunzel pune la cale un plan de evadare din turnul unde a fost ținută captivă timp de mulți ani, alături de Flynn Rider, cel mai căutat bandit al regatului, Maximus, un cal super-polițist, și Pascal, un cameleon super-protector.',
        time: 120,
        imageUrl:
            'https://media.npr.org/assets/artslife/movies/2010/11/tangled/wanted_wide-a4a868cedd4484b6dcf460cff2294a135f816733-s1100-c50.jpg',
        numar_vizualizari: 0),
    Product(
        id: 'p3',
        title: 'Despicable Me',
        description:
            'Un bărbat urzeşte nişte planuri diabolice: el vrea să fure luna de pe cer! Dar complicatele lui stratageme sunt date peste cap în momentul în care ajunge, printr-un inexplicabil concurs de împrejurări, să aibă grijă de trei orfani.',
        time: 125,
        imageUrl:
            'https://www.looper.com/img/gallery/despicable-me-4-what-we-know-so-far/l-intro-1653244829.jpg',
        numar_vizualizari: 0),
    Product(
        id: 'p4',
        title: 'Ice Age 2: The Meltdown',
        description:
            'Epoca de Gheata este pe sfarsite... gheata incepe sa se topeasca, lucru care le va distruge valea prietenilor nostri. Cei trei eroi trebuie sa-i previna pe cei din vale despre pericolul ce-i paste.',
        time: 97,
        imageUrl:
            'http://images2.fanpop.com/image/photos/9800000/Ice-Age-2-Wallpapers-ice-age-2-the-meltdown-9855288-1280-1024.jpg',
        numar_vizualizari: 0)
  ];

  List<Product> get items {
    return [...items_new];
  }

  Product findById(String id) {
    return items_new.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://flutter-movies-37c36-default-rtdb.europe-west1.firebasedatabase.app/movies.json';
    try {
      final response = await http.get(Uri.parse(url));
      print(response);
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    print("functie add");
    const url =
        'https://flutter-movies-37c36-default-rtdb.europe-west1.firebasedatabase.app/movies.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'time': product.time,
            'numar_vizualizari': product.numar_vizualizari,
          },
        ),
      )
          // .then((response) {
          //print(json.decode(response.body));
          ;

      final newProduct = Product(
        title: product.title,
        description: product.description,
        time: product.time,
        imageUrl: product.imageUrl,
        numar_vizualizari: product.numar_vizualizari,
        id: json.decode(response.body)['name'],
      );
      items_new.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = items_new.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      items_new[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    var url =
        'https://flutter-movies-37c36-default-rtdb.europe-west1.firebasedatabase.app/$id.json';
    await http.delete(
      Uri.parse(url),
    );
    items_new.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  void incrementareNrVizualizari(Product actual) {
    actual.numar_vizualizari++;
    final index = items_new.indexWhere((element) => actual.id == element.id);
    items_new[index] = actual;
    //notifyListeners();
  }
}
