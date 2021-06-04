import 'package:flutter/material.dart';

class UserActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SimpleDialog(
          title: Text("What do you want?", style: TextStyle(color: Colors.white),),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Delete", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              onPressed: ()
              {
                Navigator.pop(context);                
              },
            ),
            SimpleDialogOption(
              child: Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              onPressed: ()=> Navigator.pop(context),
            ),
          ],
        ),
    );
  }
}