import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'common.dart';
import 'models/product.dart';

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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Loading Demo'),
      ),
      body: _getListedWidget(context),
    );
  }

  Widget _getListedWidget(context) {
    return FutureBuilder<Product>(
        future: _getProductListData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return _getProductWidget(snapshot.data);
          }

          return CircularProgressIndicator();
        });
  }

  Widget _getProductWidget(Product product) {
    return ListTile(
      title: Text(product.name),
      trailing: Text(product.price),
    );
  }

  Widget _getSimpleWidget() {
    return Center(
      child: RaisedButton(
        child: Text('CLICK'),
        onPressed: () {
          print("Clicked");

          final future = http.get(fetchProductsUrl);
          future.then((response) {
            if (response.statusCode == 200) {
              print('Success ${response.body}');
            }
          }).catchError((err) {
            print(err.toString());
          }).whenComplete(() {
            print("Completed the Future Call");
          });
        },
      ),
    );
  }

  Future<Product> _getProductListData() async {
    final response = await http.get(fetchSingleProductUrl);

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load products');
    }
  }
}
