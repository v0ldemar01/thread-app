import 'package:flutter/material.dart';

class User {
  String id;
  String email;
  String username;
  String avatar;
  String userStatus;
  String password;
  String token;

  User({ 
    @required this.id, 
    @required this.email, 
    @required this.username, 
    this.password, 
    @required this.avatar, 
    @required this.userStatus, 
    @required this.token
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    if (responseData['user'] != null) {
      return User(      
        id: responseData['user']['id'] as String,  
        email: responseData['user']['email'] as String,
        username: responseData['user']['username'] as String,
        avatar: responseData['user']['avatar'] as String,
        userStatus: responseData['user']['userStatus'] as String,
        password: responseData['user']['password'] as String,
        token: responseData['token'] as String,      
      );
    }
    return User(        
      id: responseData['id'] as String,  
      email: responseData['email'] as String,
      username: responseData['username'] as String,
      avatar: responseData['avatar'] as String,
      userStatus: responseData['userStatus'] as String,
      password: responseData['password'] as String,
      token: responseData['token'] as String,      
    );
  }
}
