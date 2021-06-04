import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thread_app/bloc/post_bloc/post_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_event.dart';
import 'package:thread_app/bloc/post_bloc/post_state.dart';
import 'package:thread_app/bloc/user_bloc/user_bloc.dart';
import 'package:thread_app/bloc/user_bloc/user_event.dart';
import 'package:thread_app/bloc/user_bloc/user_state.dart';
import 'package:thread_app/helpers/image_helper.dart';
import 'package:thread_app/pages/details_page.dart';
import 'package:thread_app/services/post_service.dart';
import 'package:thread_app/widgets/components/post_field.dart';
import 'package:thread_app/widgets/components/switch.dart';
import 'package:thread_app/widgets/post_list.dart';

class HomePage extends StatelessWidget {
  final postService = PostService();     
  
  @override
  Widget build(BuildContext context) {
    final UserState userState = BlocProvider.of<UserBloc>(context).state; 
    return BlocProvider<PostBloc>(
      create: (context) {
        final postService = PostService();      
        return PostBloc(postService: postService)
          ..add(PostFetchEvent(
            userId: (userState as AuthSuccess).user.id
          )
        );
      },                   
      child: BlocListener<PostBloc, PostState>(
        listener: (context, state) async {            
          if (state is PostDetailsState) {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<PostBloc>(), 
                    child: DetailsPage(
                      post: state.post,
                      currentUserId: (userState as AuthSuccess).user.id,
                    ),
                  );
                }  
              )
            );
            BlocProvider.of<PostBloc>(context)
              .add(PostFetchEvent(
                userId: (userState as AuthSuccess).user.id
              ));
          }
        },            
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  getUserImgLink((userState as AuthSuccess).user.avatar)
                ),
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (userState as AuthSuccess).user.username ?? '',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 18.0
                  ),
                ),
                Text(
                  (userState as AuthSuccess).user.userStatus ?? '',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 14.0
                  ),
                )
              ], 
            ),
            actions: <Widget>[
              IconButton(
                visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                onPressed: () {
                  
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.exit_to_app ,
                  color: Colors.white,
                ),
                onPressed: () {
                  BlocProvider.of<UserBloc>(context)..add(UserLoggedOut());
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[      
                PostField(),
                SwitchElement(
                  fieldName: 'Sort posts by date',
                  type: 'date'
                ),
                SwitchElement(
                  fieldName: 'Sort posts by like count',
                  type: 'likeCount'
                ),
                SwitchElement(
                  fieldName: 'Sort posts by dislike count',
                  type: 'dislikeCount'
                ),
                SwitchElement(
                  fieldName: 'Filter posts by user',
                  type: 'user'
                ),
                Container (
                  child: PostList(
                    currentUserId: (userState as AuthSuccess).user.id,
                  ),
                ),
              ],
            ), 
          ),
        ),
      ),
    );
  }
}