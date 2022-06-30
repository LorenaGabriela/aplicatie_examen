import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie.dart';
import '../providers/movies.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedproduct = Product(
      id: '',
      title: '',
      time: 0,
      description: '',
      imageUrl: '',
      numar_vizualizari: 0);
  var _initValues = {
    'title': '',
    'description: ': '',
    'price': '',
    'imageUrl': ''
  };
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String?;
      if (productId != null) {
        _editedproduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedproduct.title,
          'description': _editedproduct.description,
          'price': _editedproduct.time.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedproduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    if (_editedproduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedproduct.id, _editedproduct);
    }
    // } else {
    //   Provider.of<Products>(context, listen: false).addProduct(_editedproduct);
    // }
    Provider.of<Products>(context, listen: false).addProduct(_editedproduct);

    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
          actions: <Widget>[
            IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
          ],
        ),
        //form()-invisible, you can use special input and you can group
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _form,
                //listview sau column -> makes scrollable
                child: ListView(children: <Widget>[
                  TextFormField(
                    initialValue: _initValues['title'],
                    decoration: InputDecoration(labelText: 'Titlu'),
                    //wil move to the next input instead of submitting
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please return a value';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedproduct = Product(
                          title: value.toString(),
                          time: _editedproduct.time,
                          description: _editedproduct.description,
                          imageUrl: _editedproduct.imageUrl,
                          id: _editedproduct.id,
                          numar_vizualizari: _editedproduct.numar_vizualizari);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['time'],
                    decoration: InputDecoration(labelText: 'Durata Film'),
                    //wil move to the next input instead of submitting
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,

                    onSaved: (value) {
                      //print(value.runtimeType);
                      _editedproduct = Product(
                          title: _editedproduct.title,
                          time: int.parse(value.toString()),
                          description: _editedproduct.description,
                          imageUrl: _editedproduct.imageUrl,
                          id: _editedproduct.id,
                          numar_vizualizari: _editedproduct.numar_vizualizari);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Adauga durata filmului';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Adauga un numar valid';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Adauga un numar mai mare decat 0';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['description'],
                    decoration: InputDecoration(labelText: 'Descriere'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    //wil move to the next input instead of submitting
                    focusNode: _descriptionFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Adauga o descriere a filmului';
                      }
                      if (value.length < 10) {
                        return 'Cel putin 10 caractere';
                      }
                      return null;
                    },

                    onSaved: (value) {
                      _editedproduct = Product(
                          title: _editedproduct.title,
                          time: _editedproduct.time,
                          description: value.toString(),
                          imageUrl: _editedproduct.imageUrl,
                          id: _editedproduct.id,
                          numar_vizualizari: _editedproduct.numar_vizualizari);
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Adauga adresa URL')
                            : FittedBox(
                                child: Image.network(_imageUrlController.text,
                                    fit: BoxFit.cover)),
                      ),
                      Expanded(
                        child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) => {_saveForm()},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an image';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Adresa URL invalida';
                              }
                              if (!value.endsWith('jpg') &&
                                  !value.endsWith('png') &&
                                  !value.endsWith('jpeg')) {
                                return 'Adresa URL invalida';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedproduct = Product(
                                  title: _editedproduct.title,
                                  time: _editedproduct.time,
                                  description: _editedproduct.description,
                                  imageUrl: value.toString(),
                                  id: _editedproduct.id,
                                  numar_vizualizari:
                                      _editedproduct.numar_vizualizari);
                            }),
                      )
                    ],
                  )
                ]))));
  }
}
