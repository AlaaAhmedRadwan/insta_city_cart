
import 'package:dartz/dartz.dart';

import '../../core/error/error_exeptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/api_constant.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class BasicCartRemoteDataSource {
  Future getCartList();
}

class CartRemoteDataSource implements BasicCartRemoteDataSource {
  @override
  Future<List<Map<String, dynamic>>> getCartList() async {
    final url = Uri.parse(ApiConstant.url);
    // Define the request body
    var body = jsonEncode({
      "code": "12",
      "user_id": 617
    });

    // Make the POST request
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the response JSON
      var responseData = jsonDecode(response.body);

      // Print the response data
      print(responseData);

      // Return the parsed response data
      return List<Map<String, dynamic>>.from(responseData['carts']);
    } else {
      var responseData = jsonDecode(response.body);

      // If the request was not successful, throw an exception
      return List<Map<String, dynamic>>.from(responseData['carts']);
    }
  }
}

