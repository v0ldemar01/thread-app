import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_state.dart';
import 'package:thread_app/widgets/components/post_field.dart';

import 'components/post.dart';

class PostList extends StatelessWidget { 
  final currentUserId;
  PostList({this.currentUserId}): assert(currentUserId != null);
  
  @override
  Widget build(BuildContext context) {   
    
    return BlocBuilder<PostBloc, PostState>(      
      builder: (context, state) {
        if (state is PostInitState) {
          return Center(
            child: Text(
              'No data received',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }           
        if (state is PostFetchedState) {          
          return ListView.builder(     
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),           
            itemCount: state.posts.length,
            itemBuilder: (context, index) => Post(
              post: state.posts[index],
              currentUserId: currentUserId,
            ),
          );
        }  
        if (state is PostEditInitState) {
          return ListView.builder(      
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),        
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              if (post.id == state.post.id) {
                return PostField(
                  post: post
                );
              } else {
                return Post(
                  post: post,
                  currentUserId: currentUserId,
                );
              }
            }
          );
        }       
        return Center(
          child: CircularProgressIndicator(),
        );
      },      
    );
  }
}