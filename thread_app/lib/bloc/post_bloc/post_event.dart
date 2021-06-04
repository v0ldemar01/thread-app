import 'package:flutter/material.dart';

abstract class PostEvent {}

class PostFetchEvent extends PostEvent {
  final userId;
  PostFetchEvent({this.userId}): assert(userId != null);
}

class PostAddEvent extends PostEvent {
  final post;
  PostAddEvent({ @required this.post}): assert(post != null);

   @override
  List<Object> get props => [post];
}

class PostEditInitEvent extends PostEvent {
  final post;
  PostEditInitEvent({ @required this.post}): assert(post != null);

   @override
  List<Object> get props => [post];
}

class PostEditEvent extends PostEvent {
  final post;
  PostEditEvent({ @required this.post}): assert(post != null);

   @override
  List<Object> get props => [post];
}

class PostDeleteEvent extends PostEvent {
  final String id;

  PostDeleteEvent({ @required this.id}): assert(id != null);

   @override
  List<Object> get props => [id];
}

class PostLikeEvent extends PostEvent {
  final post;
  PostLikeEvent({ @required this.post}): assert(post != null);

   @override
  List<Object> get props => [post];
}

class PostDisLikeEvent extends PostEvent {
  final post;
  PostDisLikeEvent({ @required this.post}): assert(post != null);

   @override
  List<Object> get props => [post];
}

class PostDetailEvent extends PostEvent {
  final post;
  PostDetailEvent({ @required this.post}): assert(post != null);

   @override
  List<Object> get props => [post];
}

class PostFilterUserEvent extends PostEvent {
  final userId;
  PostFilterUserEvent({ @required this.userId}): assert(userId != null);

   @override
  List<Object> get props => [userId];
}

class PostSortByDateEvent extends PostEvent {}

class PostSortByLikeCountEvent extends PostEvent {}

class PostSortByDislikeCountEvent extends PostEvent {}

class PostCancelFilterEvent extends PostEvent {}

