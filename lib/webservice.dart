import 'package:http/http.dart' as http;
import 'constants.dart';

class Api {
  static Future getProducts() {
    print('Get Products Called');
    return http.get(fetchProductsUrl);
  }
}