//EDITED BY ROSIE
// import 'dart:convert';

// import 'package:http/http.dart' as http;

// Future<double> getPrice(String id) async {
//   try {
//     var url = "https://api.coingecko.com/api/v3/coins/" + id;
//     var response = await http.get(url);
//     var json = jsonDecode(response.body);
//     var value = json['market_data']['current_price']['php'].toString();
//     return double.parse(value);
//   } catch (e) {
//     print(e.toString());
//     return 0.0;
//   }
// }
