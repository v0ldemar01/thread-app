import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thread_app/models/post.dart';
import 'package:thread_app/services/post_service.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService postService;
  List<Post> posts;
  List<Post> sortedPosts;
  String userId;

  PostBloc({this.postService}) : assert(postService != null), super(PostInitState());  
  // ignore: non_constant_identifier_names
  List<Post> PostStateOperation(List<dynamic> addInfo, [Post newPost]) =>
    posts.map<Post>((post) {
      var thisPost;
      if (newPost != null && post.id == newPost.id) {
        thisPost =  newPost;
      } else {
        thisPost = post;
      }
      addInfo.forEach((element) {
        if (post.id == element['postId']) {
          if (element['isLike']) {                
            thisPost.currentUserReaction = 1;
          } else {                
            thisPost.currentUserReaction = -1;
          }
        }
      });
      return thisPost;
    }).toList();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');    
    if (event is PostFetchEvent) {      
      try {            
        posts = await postService.getPosts(token);   
        userId = event.userId;           
        final List<dynamic> additionalInfo = await postService.getUserReactPosts(token, userId);  
        posts = PostStateOperation(additionalInfo);
        yield PostFetchedState(posts: posts);        
      } catch (err) {
        yield PostErrorState(message: err);
      }
    } 

    if (event is PostAddEvent) {
      try {        
        final Post post = await postService.addPost(token, event.post);        
        posts.insert(0, post);        
        yield PostFetchedState(posts: posts);    
      } catch (err) {        
        yield PostErrorState(message: err);
      }
    }

    if (event is PostEditInitEvent) {
      yield PostEditInitState(post: event.post, posts: posts);
    }

    if (event is PostDetailEvent) {
      yield PostDetailsState(post: event.post);
    }

    if (event is PostEditEvent) {      
      try {        
        final Post newPost = await postService.editPost(token, event.post);
        posts = posts.map((post) {
          if (post.id == newPost.id) {
            return newPost;
          } else {
            return post;
          }
        }).toList();
        yield PostFetchedState(posts: posts);   
      } catch (err) {        
        yield PostErrorState(message: err);
      }
    } 

    if (event is PostDeleteEvent) {
      try {                
        // final Post post = await postService.deletePost(token, event.id);        
        posts = posts.where((post) => post.id != event.id).toList();        
        yield PostFetchedState(posts: posts);    
      } catch (err) {           
        yield PostErrorState(message: err);
      }
    }

    if (event is PostLikeEvent) {
      try {        
        final Post newPost = await postService.likePost(token, event.post);        
        final List<dynamic> additionalInfo = await postService.getUserReactPosts(token, userId);  
        posts = PostStateOperation(additionalInfo, newPost);
        yield PostFetchedState(posts: posts);   
      } catch (err) {        
        yield PostErrorState(message: err);
      }
    }    
    
    if (event is PostDisLikeEvent) {
      try {
        final Post newPost = await postService.dislikePost(token, event.post);        
        final List<dynamic> additionalInfo = await postService.getUserReactPosts(token, userId);        
        posts = PostStateOperation(additionalInfo, newPost);
        yield PostFetchedState(posts: posts);   
      } catch (err) {
        yield PostErrorState(message: err);
      }
    }

    if (event is PostSortByDateEvent) {
      sortedPosts = List.from(posts);
      sortedPosts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      yield PostFetchedState(posts: sortedPosts); 
    }

    if (event is PostSortByLikeCountEvent) {
      sortedPosts = List.from(posts);
      sortedPosts.sort((a, b) => b.likeCount.compareTo(a.likeCount));
      yield PostFetchedState(posts: sortedPosts); 
    }

    if (event is PostSortByDislikeCountEvent) {      
      sortedPosts = List.from(posts);
      sortedPosts.sort((a, b) => b.dislikeCount.compareTo(a.dislikeCount));
      yield PostFetchedState(posts: sortedPosts); 
    }

    if (event is PostFilterUserEvent) {     
      final filterPosts = posts.where((post) => post.userId == event.userId).toList();      
      yield PostFetchedState(posts: filterPosts); 
    }

    if (event is PostCancelFilterEvent) {
      yield PostFetchedState(posts: posts);   
    }
  }
}