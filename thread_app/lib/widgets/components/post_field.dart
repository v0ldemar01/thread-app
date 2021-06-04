import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_event.dart';
import 'package:thread_app/utils/validate/postBody.dart';
import 'package:thread_app/widgets/auth/auth_widgets.dart';

class PostField extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final _postController = TextEditingController();
  final post;

  PostField({this.post = null});

  @override
  _PostFieldState createState() => _PostFieldState();
}

class _PostFieldState extends State<PostField> {
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostBloc>(context);    
    if (widget.post != null) {
      widget._postController.text = widget.post.body;
    }
  }

  @override
  void dispose() {    
    widget._postController.dispose();        
    super.dispose();
  }

  void _submitForm() {
    if (widget._formKey.currentState.validate()) {
      widget._formKey.currentState.save(); 
      if (widget.post != null) {       
        _postBloc.add(
          PostEditEvent(
            post: {'id': widget.post.id, 'body': widget._postController.text}
          ),
        );
      } else {         
        _postBloc.add(
          PostAddEvent(
            post: {'body': widget._postController.text}
          ),
        );
      }     
      widget._postController.clear();
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
                        controller: widget._postController,              
                        decoration: InputDecoration(
                          labelText: 'Post',
                          hintText: 'Tell us about your self',                    
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
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
                              minWidth: 15.0,
                              height: 35,
                              color: Color(0xFF801E48),
                              child: new Text(
                                'Upload image',
                                style: new TextStyle(
                                  fontSize: 16.0, 
                                  color: 
                                  Colors.white
                                )
                              ),
                              onPressed: () {
                  
                              },
                            ),
                            MaterialButton(
                              minWidth: 45.0,
                              height: 35,
                              color: Colors.blue[400],
                              child: new Text(
                                widget.post != null ? 'Edit' : 'Create',
                                style: new TextStyle(
                                  fontSize: 16.0, 
                                  color: Colors.white
                                )
                              ),
                              onPressed: () => _submitForm(),
                            )    
                          ],
                        ),
                      )
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