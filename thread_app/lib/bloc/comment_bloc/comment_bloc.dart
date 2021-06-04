import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thread_app/models/comment.dart';
import 'package:thread_app/services/comment_service.dart';

import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentService commentService;
  List<Comment> comments;
  String userId;
  String postId;

  CommentBloc({this.commentService}) : assert(commentService != null), super(CommentInitState());  
  // ignore: non_constant_identifier_names
  List<Comment> PostStateOperation(List<dynamic> addInfo, [Comment newComment]) =>
    comments.map<Comment>((comment) {
      var thisComment;
      if (newComment != null && comment.id == newComment.id) {
        thisComment =  newComment;
      } else {
        thisComment = comment;
      }
      addInfo.forEach((element) {
        if (comment.id == element['commentId']) {
          if (element['isLike']) {                
            thisComment.currentUserReaction = 1;
          } else {                
            thisComment.currentUserReaction = -1;
          }
        }
      });
      return thisComment;
    }).toList();

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');    
    if (event is CommentFetchEvent) {      
      try {  
        userId = event.userId;
        postId = event.postId;          
        comments = await commentService.getComments(token, postId);              
        final List<dynamic> additionalInfo = await commentService.getUserReactComments(token, event.userId);  
        comments = PostStateOperation(additionalInfo);
        yield CommentFetchedState(comments: comments);        
      } catch (err) {        
        yield CommentErrorState(message: err);
      }
    } 

    if (event is CommentAddEvent) {
      try {        
        final Comment comment = await commentService.addComment(token, event.comment);        
        comments.insert(0, comment);        
        yield CommentFetchedState(comments: comments);    
      } catch (err) {        
        yield CommentErrorState(message: err);
      }
    }
    if (event is CommentEditInitEvent) {
      yield CommentEditInitState(comment: event.comment, comments: comments);
    }

    if (event is CommentEditEvent) {      
      try {        
        final Comment newPost = await commentService.editComment(token, event.comment);
        comments = comments.map((post) {
          if (post.id == newPost.id) {
            return newPost;
          } else {
            return post;
          }
        }).toList();
        yield CommentFetchedState(comments: comments);   
      } catch (err) {        
        yield CommentErrorState(message: err);
      }
    } 

    if (event is CommentDeleteEvent) {
      try {                
        // final Post post = await postService.deletePost(token, event.id);        
        comments = comments.where((comment) => comment.id != event.id).toList();        
        yield CommentFetchedState(comments: comments);    
      } catch (err) {           
        yield CommentErrorState(message: err);
      }
    }

    if (event is CommentLikeEvent) {
      try {
        final Comment newComment = await commentService.likeComment(token, event.comment);        
        final List<dynamic> additionalInfo = await commentService.getUserReactComments(token, userId);  
        comments = PostStateOperation(additionalInfo, newComment);
        yield CommentFetchedState(comments: comments);   
      } catch (err) {
        yield CommentErrorState(message: err);
      }
    }
    
    if (event is CommentDisLikeEvent) {
      try {
        final Comment newComment = await commentService.dislikeComment(token, event.comment);        
        final List<dynamic> additionalInfo = await commentService.getUserReactComments(token, userId);  
        comments = PostStateOperation(additionalInfo, newComment);
        yield CommentFetchedState(comments: comments);   
      } catch (err) {
        yield CommentErrorState(message: err);
      }
    }
  }
}