import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nelnotes/data/base_url/base_url.dart';
import 'package:flutter_nelnotes/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<List<UserModel>> getUser(String userId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/account/$userId"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        return result.map((json) => UserModel.fromJson(json)).toList();
      } else {
        debugPrint("Gagal get user");
        return [];
      }
    } catch (e) {
      debugPrint("error:$e");
      return [];
    }
  }
}
