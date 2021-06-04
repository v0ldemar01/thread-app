import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thread_app/constants/api.dart';
import 'package:thread_app/helpers/web_api_helper.dart';
import 'package:thread_app/models/user.dart';

class AuthService {
  Future<User> getCurrentUser(String token) async {    
    var requestUrl = Uri.http(API.address, '${API.getUser}');    
    var headers = getHeader(token);    
    final response = await http.get(requestUrl, headers: headers);   
    if (response.statusCode == 200) {
      final User user = User.fromJson(json.decode(response.body));      
      return user;
    } else {
      throw Exception(response.body.toString());
    }
  }

  Future<User> login(String phone, String password) async {
    var requestUrl = Uri.http(API.address, '${API.login}');
    var headers = getHeader();
    final Map<String, String> data = {
      'phone': phone,
      'password': password,
    };
    String body = json.encode(data);    
    final response = await http.post(requestUrl, headers: headers, body: body);
    
    if (response.statusCode == 200) {      
      final User user = User.fromJson(json.decode(response.body));      
      return user;
    } else {
      throw Exception(response.body.toString());
    }
  }

  Future<User> register(String phone, String username, String password) async {
    var requestUrl = Uri.http(API.address, '${API.register}');    
    var headers = getHeader();
    final Map<String, String> data = {
      'phone': phone,
      'username': username,
      'password': password,
    };
    String body = json.encode(data);    
    final response = await http.post(requestUrl, headers: headers, body: body);    
    if (response.statusCode == 200) {
      final User user = User.fromJson(json.decode(response.body));
      return user;
    } else {
      throw Exception(response.body.toString());
    }
  }

  Future<void> signOut() async {
    return null;
  }
}


