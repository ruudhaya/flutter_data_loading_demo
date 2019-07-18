import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'common.dart';

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
      body: Center(
        child: RaisedButton(
          child: Text('CLICK'),
          onPressed: () {
            print("Clicked");

            final future = http.get(fetchBooksUrl);
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
      ),
    );
  }
}
