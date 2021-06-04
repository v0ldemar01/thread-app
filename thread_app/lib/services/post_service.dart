import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thread_app/constants/api.dart';
import 'package:thread_app/helpers/web_api_helper.dart';
import 'package:thread_app/models/post.dart';

class PostService {
  Future<dynamic> getPosts(String token) async {
    var requestUrl = Uri.http(API.address, '${API.posts}');
    var headers = getHeader(token);       
    final response = await http.get(requestUrl, headers: headers);      
    if (response.statusCode == 200) {          
      final List<dynamic> postsJson = json.decode(response.body);      
      return postsJson.map((json) => Post.fromJson(json)).toList();     
    } else {      
      throw Exception(response.body.toString());
    }
  }

  Future<dynamic> getUserReactPosts(String token, String userId) async {
    var requestUrl = Uri.http(API.address, '${API.postsReact}/$userId');
    var headers = getHeader(token);     
    final response = await http.get(requestUrl, headers: headers);    
    if (response.statusCode == 200) {
      final additionalInfo = json.decode(response.body);
      return additionalInfo;
    } else {
      throw Exception(response.body.toString());
    } 
  }

  Future<Post> addPost(String token, dynamic post) async {
    var requestUrl = Uri.http(API.address, '${API.posts}');
    var headers = getHeader(token);    
    String body = json.encode(post);    
    final response = await http.post(requestUrl, headers: headers, body: body);      
    if (response.statusCode == 200) {
      final Post post = Post.fromJson(json.decode(response.body));
      return post;
    } else {
      throw Exception(response.body.toString());
    }
  }

  Future<dynamic> editPost(String token, dynamic post) async {
    var requestUrl = Uri.http(API.address, '${API.posts}/${post['id']}');
    var headers = getHeader(token);    
    String body = json.encode(post);    
    final response = await http.put(requestUrl, headers: headers, body: body);    
    if (response.statusCode == 200) {
      final Post post = Post.fromJson(json.decode(response.body));
      return post;
    } else {
      throw Exception(response.body.toString());
    }
  }

  Future<dynamic> reactWrapper(String token, dynamic post, String type) async {
    var requestUrl = Uri.http(API.address, '${API.postsReact}');
    var headers = getHeader(token);
    final Map<String, String> data = {
      'postId': post.id,
      '$type': 'true'      
    };
    String body = json.encode(data);    
    final response = await http.put(requestUrl, headers: headers, body: body);     
    if (response.statusCode == 200) {
      final Post post = Post.fromJson(json.decode(response.body));
      return post;
    } else {
      throw Exception(response.body.toString());
    }  
  }

  Future<dynamic> likePost(String token, dynamic post) async => await reactWrapper(token, post, 'isLike');

  Future<dynamic> dislikePost(String token, dynamic post) async => await reactWrapper(token, post, 'isDisLike'); 
}
