import 'package:flutter/material.dart';

class Comment {
  String id;
  String body;
  Map<String, dynamic> user;
  String userId;
  String postId;
  String username;
  Map<String, dynamic> image;
  String likeCount;
  String dislikeCount;
  String createdAt;
  String updatedAt;
  int currentUserReaction;   

  Comment({ 
    this.id, 
    @required this.body, 
    @required this.userId, 
    @required this.postId,
    @required this.username,
    this.image, 
    @required this.likeCount, 
    @required this.dislikeCount,     
    this.createdAt, 
    this.updatedAt,
    currentUserReaction = 0
  });

  factory Comment.fromJson(Map<String, dynamic> responseData) {
    return Comment(        
      id: responseData['id'] as String,
      body: responseData['body'] as String,
      userId: responseData['user']['id'] as String,
      postId: responseData['postId'] as String,
      username: responseData['user']['username'] as String,
      image: responseData['image'] as Map<String, dynamic>,
      likeCount: responseData['likeCount'] as String,
      dislikeCount: responseData['dislikeCount'] as String,      
      createdAt: responseData['createdAt'] as String,    
      updatedAt: responseData['updatedAt'] as String,      
    );
  }
}
