import 'package:flutter/material.dart';

class Post {
  String id;
  String body;
  Map<String, dynamic> user;
  String userId;
  String username;
  Map<String, dynamic> image;
  String likeCount;
  String dislikeCount;
  String commentCount;
  String createdAt;
  String updatedAt;
  int currentUserReaction;   

  Post({ 
    this.id, 
    @required this.body, 
    @required this.userId, 
    @required this.username,
    this.image, 
    @required this.likeCount, 
    @required this.dislikeCount, 
    @required this.commentCount, 
    this.createdAt, 
    this.updatedAt,
    currentUserReaction = 0
  });

  factory Post.fromJson(Map<String, dynamic> responseData) {
    return Post(        
      id: responseData['id'] as String,
      body: responseData['body'] as String,
      userId: responseData['user']['id'] as String,
      username: responseData['user']['username'] as String,
      image: responseData['image'] as Map<String, dynamic>,
      likeCount: responseData['likeCount'] as String,
      dislikeCount: responseData['dislikeCount'] as String,
      commentCount: responseData['commentCount'] as String,
      createdAt: responseData['createdAt'] as String,    
      updatedAt: responseData['updatedAt'] as String,      
    );
  }
}
