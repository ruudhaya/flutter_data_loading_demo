import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/product.dart';
import 'webservice.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Loading Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class CataloguePage extends StatefulWidget {
  @override
  _CataloguePageState createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  var productList = List<Product>();

  _getProducts() {
    Api.getProducts().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        productList = list.map((model) => Product.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(productList[index].name),
          );
        },
        itemCount: productList.length,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Loading Demo'),
      ),
      body: CataloguePage(),
    );
  }
}
