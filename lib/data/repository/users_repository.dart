import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc_practice/logic/model/user_model.dart';
import 'package:http/http.dart' as http;

class UsersRepository {
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        log('Api success with status code ${response.statusCode} ,body: ${response.body}');
        final List<dynamic> data = jsonDecode(response.body);
        // final List<Post> posts = data.map((e) => Post.fromJson(e)).toList();

        return data.map((e) => UserModel.fromJson(e)).toList();
      } else {
        throw Exception(
            'Api failure with status code ${response.statusCode} ,body: ${response.body}');
      }
    } on SocketException {
      throw Exception('Api failure with socket exception');
    } on TimeoutException {
      throw Exception('Api failure with socket exception');
    } catch (e) {
      log('error', error: e);
      throw Exception(e);
    }
  }
}
