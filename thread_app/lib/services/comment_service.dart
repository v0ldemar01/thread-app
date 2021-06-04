import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thread_app/constants/api.dart';
import 'package:thread_app/helpers/web_api_helper.dart';
import 'package:thread_app/models/comment.dart';

class CommentService {
  Future<dynamic> getComments(String token, String postId) async {
    var queryParameters = {
      'postId': postId,    
    };
    var requestUrl = Uri.http(API.address, '${API.comments}', queryParameters);  
    var headers = getHeader(token);       
    final response = await http.get(requestUrl, headers: headers);      
    if (response.statusCode == 200) {          
      final List<dynamic> commentsJson = json.decode(response.body);      
      return commentsJson.map((json) => Comment.fromJson(json)).toList();     
    } else {      
      throw Exception(response.body.toString());
    }
  }

  Future<dynamic> getUserReactComments(String token, String userId) async {
    var requestUrl = Uri.http(API.address, '${API.commentsReact}/$userId');
    var headers = getHeader(token);     
    final response = await http.get(requestUrl, headers: headers);     
    if (response.statusCode == 200) {
      final additionalInfo = json.decode(response.body);
      return additionalInfo;
    } else {
      throw Exception(response.body.toString());
    } 
  }

  Future<Comment> addComment(String token, dynamic comment) async {
    var requestUrl = Uri.http(API.address, '${API.comments}');
    var headers = getHeader(token);    
    String body = json.encode(comment);    
    final response = await http.post(requestUrl, headers: headers, body: body);      
    if (response.statusCode == 200) {
      final Comment comment = Comment.fromJson(json.decode(response.body));
      return comment;
    } else {
      throw Exception(response.body.toString());
    }
  }

  Future<dynamic> editComment(String token, dynamic comment) async {
    var requestUrl = Uri.http(API.address, '${API.comments}/${comment['id']}');
    var headers = getHeader(token);    
    String body = json.encode(comment);    
    final response = await http.put(requestUrl, headers: headers, body: body);    
    if (response.statusCode == 200) {
      final Comment comment = Comment.fromJson(json.decode(response.body));
      return comment;
    } else {
      throw Exception(response.body.toString());
    }
  }

  Future<dynamic> reactWrapper(String token, dynamic comment, String type) async {
    var requestUrl = Uri.http(API.address, '${API.commentsReact}');
    var headers = getHeader(token);
    final Map<String, String> data = {
      'commentId': comment.id,
      '$type': 'true'      
    };
    String body = json.encode(data);    
    final response = await http.put(requestUrl, headers: headers, body: body);     
    if (response.statusCode == 200) {
      final Comment comment = Comment.fromJson(json.decode(response.body));
      return comment;
    } else {
      throw Exception(response.body.toString());
    }  
  }

  Future<dynamic> likeComment(String token, dynamic comment) async => await reactWrapper(token, comment, 'isLike');

  Future<dynamic> dislikeComment(String token, dynamic comment) async => await reactWrapper(token, comment, 'isDisLike'); 
}
