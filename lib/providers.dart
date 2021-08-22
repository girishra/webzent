import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  //get all users
  Future<dynamic> getUsers() async {
    try {
      final response = await http
          .get('https://jsonplaceholder.typicode.com/posts', headers: _headers);

      final resData = convert.jsonDecode(response.body);

      if (response.statusCode >= 400) {
        throw (resData['message']);
      }
      return resData as dynamic;
    } catch (e) {
      rethrow;
    }
  }
}
