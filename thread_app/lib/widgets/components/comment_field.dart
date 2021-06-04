import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/comment_bloc/comment_bloc.dart';
import 'package:thread_app/bloc/comment_bloc/comment_event.dart';
import 'package:thread_app/bloc/post_bloc/post_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_event.dart';
import 'package:thread_app/utils/validate/postBody.dart';
import 'package:thread_app/widgets/auth/auth_widgets.dart';

class CommentField extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final comment;
  final postId;

  CommentField({this.comment = null, this.postId = null});

  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  CommentBloc _commentBloc;

  @override
  void initState() {
    super.initState();
    _commentBloc = BlocProvider.of<CommentBloc>(context);    
    if (widget.comment != null) {
      widget._commentController.text = widget.comment.body;
    }
  }

  @override
  void dispose() {    
    widget._commentController.dispose();        
    super.dispose();
  }

  void _submitForm() {
    if (widget._formKey.currentState.validate()) {
      widget._formKey.currentState.save(); 
      if (widget.comment != null) {       
        _commentBloc.add(
          CommentEditEvent(
            comment: {'id': widget.comment.id, 'body': widget._commentController.text}
          ),
        );
      } else if (widget.postId != null) {         
        _commentBloc.add(
          CommentAddEvent(
            comment: {'body': widget._commentController.text, 'postId': widget.postId}
          ),
        );
      }     
      widget._commentController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Form is not valid'),
        ),
      );
    }     
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3,
        child: ListTile(                    
          title: Form(
            key: widget._formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft, 
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      TextFormField(  
                        controller: widget._commentController,              
                        decoration: InputDecoration(
                          labelText: 'Comment',
                          hintText: 'Tell us about your self',                    
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 1,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200),
                        ],
                        validator: validatePostBody,
                        onSaved: (value) => {},
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [                            
                            MaterialButton(
                              minWidth: 45.0,
                              height: 35,
                              color: Colors.blue[400],
                              child: new Text(
                                widget.comment != null ? 'Edit' : 'Create',
                                style: new TextStyle(
                                  fontSize: 16.0, 
                                  color: Colors.white
                                )
                              ),
                              onPressed: () => _submitForm(),
                            ),    
                          ],
                        ),
                      ),
                    ],
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