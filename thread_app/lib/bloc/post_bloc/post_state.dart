import 'package:flutter/foundation.dart';
import 'package:thread_app/models/post.dart';

abstract class PostState {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitState extends PostState {}

class PostFetchedState extends PostState {
  List<Post> posts;
  PostFetchedState({@required this.posts}) : assert(posts != null);
  
  @override
  List<Object> get props => [posts];
}

class PostEditInitState extends PostState {
  List<dynamic> posts;
  dynamic post;
  PostEditInitState({@required this.post, @required this.posts}) : assert(post != null || posts != null);
  
  @override
  List<Object> get props => [post, posts];
}

class PostErrorState extends PostState {
  final Exception message;

  PostErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

class PostDetailsState extends PostState {
  Post post;
  PostDetailsState({@required this.post}) : assert(post != null);

  @override
  List<Object> get props => [post];
}

class PostFilterUserState extends PostState {
  List<dynamic> posts;
  List<dynamic> filterPosts;
  PostFilterUserState({@required this.posts, @required this.filterPosts}) : assert(posts != null || filterPosts != null);
  
  @override
  List<Object> get props => [filterPosts, posts];
}



