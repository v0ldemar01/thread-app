import 'package:flutter/foundation.dart';

abstract class CommentState {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitState extends CommentState {}

class CommentFetchedState extends CommentState {
  List<dynamic> comments;
  CommentFetchedState({@required this.comments}) : assert(comments != null);
  
  @override
  List<Object> get props => [comments];
}

class CommentEditInitState extends CommentState {
  List<dynamic> comments;
  dynamic comment;
  CommentEditInitState({@required this.comment, @required this.comments}) : assert(comment != null || comments != null);
  
  @override
  List<Object> get props => [comment, comments];
}

class CommentErrorState extends CommentState {
  final Exception message;

  CommentErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}