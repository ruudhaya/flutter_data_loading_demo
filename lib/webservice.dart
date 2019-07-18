import 'package:http/http.dart' as http;
import 'constants.dart';

class Api {
  static Future getProducts() {
    return http.get(fetchProductsUrl);
  }
}