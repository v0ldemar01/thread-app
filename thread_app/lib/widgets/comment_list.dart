import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/comment_bloc/comment_bloc.dart';
import 'package:thread_app/bloc/comment_bloc/comment_state.dart';
import 'package:thread_app/widgets/components/comment_field.dart';

import 'components/comment.dart';

class CommentList extends StatelessWidget {  
  final currentUserId;
  CommentList({this.currentUserId}): assert(currentUserId != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(      
      builder: (context, state) {
        if (state is CommentInitState) {
          return Center(
            child: Text(
              'No data received',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }           
        if (state is CommentFetchedState) {    
          return ListView.builder(   
            shrinkWrap: true,
            itemCount: state.comments.length,
            itemBuilder: (context, index) => Comment(
              comment: state.comments[index],
              currentUserId: currentUserId
            ),
          );
        }  
        if (state is CommentEditInitState) {
          return ListView.builder(   
            shrinkWrap: true,
            itemCount: state.comments.length,
            itemBuilder: (context, index) {
              final comment = state.comments[index];
              if (comment.id == state.comment.id) {
                return CommentField(
                  comment: comment
                );
              } else {
                return Comment(
                  comment: comment,
                  currentUserId: currentUserId
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