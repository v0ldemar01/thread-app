import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_bloc.dart';
import 'package:thread_app/bloc/post_bloc/post_event.dart';
import 'package:thread_app/bloc/user_bloc/user_bloc.dart';
import 'package:thread_app/bloc/user_bloc/user_state.dart';

class SwitchElement extends StatefulWidget {
  final String fieldName;
  final String type;
  SwitchElement({this.fieldName, this.type});

  @override
  _SwitchElementState createState() => _SwitchElementState();
}

class _SwitchElementState extends State<SwitchElement> {
  bool isSwitched = false;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostBloc>(context);       
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {                
                if (value) {
                  if (widget.type == 'date') {
                    _postBloc.add(
                      PostSortByDateEvent(),
                    ); 
                  } else if (widget.type == 'likeCount') {
                    _postBloc.add(
                      PostSortByLikeCountEvent(),
                    ); 
                  } else if (widget.type == 'dislikeCount') {
                    
                    _postBloc.add(
                      PostSortByDislikeCountEvent(),
                    ); 
                  } else if (widget.type == 'user') {
                    final userState = BlocProvider.of<UserBloc>(context).state; 
                    _postBloc.add(
                      PostFilterUserEvent(    
                        userId: (userState as AuthSuccess).user.id
                      ),                      
                    ); 
                  }
                } else if (!value && isSwitched){
                  _postBloc.add(
                    PostCancelFilterEvent(),                      
                  ); 
                }
                isSwitched = value;
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
          Text(
            widget.fieldName,
            style: TextStyle(
              fontSize: 18.0
            ),
          ),
        ],
      )
    );
  }
}