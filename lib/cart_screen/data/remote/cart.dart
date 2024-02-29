import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/error/error_exeptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/api_constant.dart';

abstract class BasicCartRemoteDataSource {
  Future<Map<String, dynamic>> getCartList(); // Change the return type here
}

class CartRemoteDataSource implements BasicCartRemoteDataSource {

  @override
  Future<Map<String, dynamic>> getCartList() async {
    final url = Uri.parse(ApiConstant.url);
    var body = jsonEncode({
      "code": "12",
      "user_id": 617
    });

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
      return <String, dynamic>{
        'carts': List<Map<String, dynamic>>.from(responseData['carts']),
        'totalOrder': responseData['totalOrder'],
      };

    } else {
      // If the request was not successful, throw an exception
      throw ServerExceptionn(); // You need to define ServerException in error_exceptions.dart
    }
  }
}
class ServerExceptionn implements Exception {
  const ServerExceptionn();
}
