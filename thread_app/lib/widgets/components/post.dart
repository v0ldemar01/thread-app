import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_event.dart';
import 'package:timeago/timeago.dart' as timeago;

class Post extends StatefulWidget {
  final post;
  final currentUserId;
  final detailsDisable;
  Post({this.post, this.currentUserId, this.detailsDisable = null});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  PostBloc _postBloc;
  bool isLike = false;
  bool isDisLike = false;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostBloc>(context);       
  }
  
  @override
  Widget build(BuildContext context) {    
    isLike = widget.post.currentUserReaction == 1 ? true : false;      
    isDisLike = widget.post.currentUserReaction == -1 ? true : false; 
    
    return Container(     
      padding: EdgeInsets.only(top: 15.0),         
      child: Card(
        elevation: 3,
        child: ListTile(                    
          title: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft, 
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'posted by ${widget.post.username} - ${timeago.format(DateTime.parse(widget.post.createdAt))}',
                  style: TextStyle(
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),    
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,                                           
                  children: <Widget>[
                    Text(
                      '${widget.post.body}',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 10, 
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 40.0, left: 10.0)),
                        GestureDetector(
                          onTap: () {
                            if (widget.detailsDisable == null) {
                              _postBloc.add(
                                PostLikeEvent(    
                                  post: widget.post     
                                ),
                              );  
                            }                                                       
                          },
                          child: Row(
                            children: [
                              Icon(
                                isLike ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                size: 20.0,
                                color: Colors.pink,
                              ),
                              Padding(padding: EdgeInsets.only(top: 40.0, left: 10.0),),
                              Text(
                                widget.post.likeCount
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
                        GestureDetector(
                          onTap: () {
                            if (widget.detailsDisable == null) {
                              _postBloc.add(
                                PostDisLikeEvent(    
                                  post: widget.post     
                                ),
                              ); 
                            }                                                        
                          },
                          child: Row(
                            children: [
                              Icon(
                                isDisLike ? Icons.thumb_down_alt : Icons.thumb_down_alt_outlined,
                                size: 20.0,
                                color: Colors.pink,
                              ),
                              Padding(padding: EdgeInsets.only(top: 40.0, left: 10.0),),
                              Text(
                                widget.post.dislikeCount
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(right: 20.0)),
                        GestureDetector(
                          onTap: () => {                            
                            if (widget.detailsDisable == null) {
                              _postBloc.add(
                                PostDetailEvent(    
                                  post: widget.post     
                                ),
                              ),
                            }  
                          },                          
                          child: Row(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 20.0,
                                color: Colors.black
                              ),
                              Padding(padding: EdgeInsets.only(top: 40.0, left: 10.0),),
                              Text(
                                widget.post.commentCount
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: widget.currentUserId == widget.post.userId ? GestureDetector(
            onTap: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text('Select action:'),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {    
                          _postBloc.add(
                            PostDeleteEvent(    
                              id: widget.post.id     
                            ),
                          );                        
                          Navigator.pop(context);
                        },
                        child: Text('Delete')
                      ),
                      SimpleDialogOption(
                        onPressed: () {        
                          _postBloc.add(
                            PostEditInitEvent(    
                              post: widget.post     
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text('Edit'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {                          
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                }
              ),
            },
            child: Icon(
              Icons.more_vert, 
              color: Colors.red,            
            ),
          ) : Text(''),
        ),
      ),
    );
  }
}