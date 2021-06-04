import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/comment_bloc/comment_bloc.dart';
import 'package:thread_app/bloc/comment_bloc/comment_event.dart';
import 'package:thread_app/services/comment_service.dart';
import 'package:thread_app/widgets/comment_list.dart';
import 'package:thread_app/widgets/components/comment_field.dart';
import 'package:thread_app/widgets/components/post.dart';

class DetailsPage extends StatelessWidget {
  
  final post;  
  final currentUserId;

  DetailsPage({this.post, this.currentUserId}): assert(post != null, currentUserId != null);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {        
    return BlocProvider<CommentBloc>(
      create: (context) {
        final commentService = CommentService();      
        return CommentBloc(commentService: commentService)
          ..add(CommentFetchEvent(
            userId: currentUserId,
            postId: post.id
          )
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Post details'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.start,          
            children: <Widget>[      
              Post(
                post: post,
                detailsDisable: 'true',
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(       
                alignment: Alignment.centerLeft,     
                margin: EdgeInsets.only(
                  left: 15.0
                ),    
                child: Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18.0, 
                  ),
                ),                
              ),
              Divider(),            
              CommentList(
                currentUserId: currentUserId,
              ),
              CommentField(
                postId: post.id,
              ),
            ],
          ), 
        ), 
      ),
    );
  }
}