
import 'package:flutter/material.dart';
import 'package:flutter_data_loading_demo/models/product.dart';
import 'package:flutter_data_loading_demo/webservice.dart';
import 'dart:convert';

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
