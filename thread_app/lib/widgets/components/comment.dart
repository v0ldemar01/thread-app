import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/comment_bloc/comment_bloc.dart';
import 'package:thread_app/bloc/comment_bloc/comment_event.dart';
import 'package:thread_app/helpers/image_helper.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comment extends StatefulWidget {
  final comment;
  final currentUserId;
  
  Comment({this.comment, this.currentUserId}): assert(comment != null && currentUserId != null);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  CommentBloc _commentBloc;
  bool isLike = false;
  bool isDisLike = false;

  @override
  void initState() {
    super.initState();
    _commentBloc = BlocProvider.of<CommentBloc>(context);       
  }
  
  @override
  Widget build(BuildContext context) {    
    isLike = widget.comment.currentUserReaction == 1 ? true : false;      
    isDisLike = widget.comment.currentUserReaction == -1 ? true : false;     
    return Container(     
      padding: EdgeInsets.only(bottom: 15.0),         
      child: Card(
        elevation: 3,
        child: ListTile(  
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 44,
              maxHeight: 44,
            ),
            child: Image.network(
              getUserImgLink(),
              fit: BoxFit.cover
            ),           
          ),                 
          title: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft, 
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  '${widget.comment.username} - ${timeago.format(DateTime.parse(widget.comment.createdAt))}',
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
                      '${widget.comment.body}',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),                                        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 40.0, left: 10.0)),
                        GestureDetector(
                          onTap: () {
                            _commentBloc.add(
                              CommentLikeEvent(    
                                comment: widget.comment     
                              ),
                            );                             
                          },
                          child: Row(
                            children: [
                              Icon(
                                isLike ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                size: 20.0,
                                color: Colors.grey,
                              ),
                              Padding(padding: EdgeInsets.only(top: 40.0, left: 10.0),),
                              Text(
                                widget.comment.likeCount
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
                        GestureDetector(
                          onTap: () {
                            _commentBloc.add(
                              CommentDisLikeEvent(    
                                comment: widget.comment     
                              ),
                            );                             
                          },
                          child: Row(
                            children: [
                              Icon(
                                isDisLike ? Icons.thumb_down_alt : Icons.thumb_down_alt_outlined,
                                size: 20.0,
                                color: Colors.grey,
                              ),
                              Padding(padding: EdgeInsets.only(top: 40.0, left: 10.0),),
                              Text(
                                widget.comment.dislikeCount
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
          trailing: widget.currentUserId == widget.comment.userId ? GestureDetector(
            onTap: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text('Select action:'),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {    
                          _commentBloc.add(
                            CommentDeleteEvent(    
                              id: widget.comment.id     
                            ),
                          );                        
                          Navigator.pop(context);
                        },
                        child: Text('Delete')
                      ),
                      SimpleDialogOption(
                        onPressed: () {        
                          _commentBloc.add(
                            CommentEditInitEvent(    
                              comment: widget.comment     
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