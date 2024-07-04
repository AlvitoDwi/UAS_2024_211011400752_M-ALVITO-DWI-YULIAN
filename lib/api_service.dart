import 'dart:convert';
import 'package:http/http.dart' as http;
import 'crypto_model.dart';

class ApiService {
  static const String url = 'https://api.coinlore.net/api/tickers/';

  Future<List<Crypto>> fetchCryptos() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['data'];
      List<Crypto> cryptos =
          body.map((dynamic item) => Crypto.fromJson(item)).toList();
      return cryptos;
    } else {
      throw Exception('Failed to load cryptos');
    }
  }
}
