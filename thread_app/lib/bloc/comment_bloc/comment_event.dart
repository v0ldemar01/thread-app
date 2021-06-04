import 'package:flutter/material.dart';

abstract class CommentEvent {}

class CommentFetchEvent extends CommentEvent {
  final userId;
  final postId;
  CommentFetchEvent({this.userId, this.postId}): assert(userId != null || postId != null);
}

class CommentAddEvent extends CommentEvent {
  final comment;
  CommentAddEvent({ @required this.comment}): assert(comment != null);

   @override
  List<Object> get props => [comment];
}

class CommentEditInitEvent extends CommentEvent {
  final comment;
  CommentEditInitEvent({ @required this.comment}): assert(comment != null);

   @override
  List<Object> get props => [comment];
}

class CommentEditEvent extends CommentEvent {
  final comment;
  CommentEditEvent({ @required this.comment}): assert(comment != null);

   @override
  List<Object> get props => [comment];
}

class CommentDeleteEvent extends CommentEvent {
  final String id;

  CommentDeleteEvent({ @required this.id}): assert(id != null);

   @override
  List<Object> get props => [id];
}

class CommentLikeEvent extends CommentEvent {
  final comment;
  CommentLikeEvent({ @required this.comment}): assert(comment != null);

   @override
  List<Object> get props => [comment];
}

class CommentDisLikeEvent extends CommentEvent {
  final comment;
  CommentDisLikeEvent({ @required this.comment}): assert(comment != null);

   @override
  List<Object> get props => [comment];
}