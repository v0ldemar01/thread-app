import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 40.0, left: 125.0, right: 125.0),
      elevation: 0,         
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
      ),        
    );
  }
}

class PageGreeting extends StatelessWidget {
  final String pageGreeting;
  PageGreeting({this.pageGreeting});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      alignment: Alignment.topCenter,      
      child: Text(
        pageGreeting,
        style: TextStyle(
          color: Color(0xff00b6af),
          fontWeight: FontWeight.w700,
          fontSize: 24.0,
        ),
      ),
    ); 
  }
}

class ActionButton extends StatelessWidget {
  final String buttonName;
  final Function action;
  ActionButton({this.buttonName, this.action});
  
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: action,
      textColor: Colors.white,
      color: Colors.blue[800],
      child: SizedBox(
        width: double.infinity,
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: TextStyle(                  
            fontSize: 16.0,
          ),
        ),
      ),
      height: 45.0,      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}

class OtherAuthPage extends StatelessWidget {
  final String prevText;
  final String toPageName;
  final Widget nextPage;

  OtherAuthPage({this.prevText, this.toPageName, this.nextPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(prevText),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context, MaterialPageRoute(
                builder: (_) => nextPage
              )
            );
          },          
          child: Text(
            toPageName,
            style: TextStyle(
              color: Colors.blue, 
              fontSize: 15
            ),
          ),
        ),
      ],
    );
  }
}

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context, MaterialPageRoute(
            builder: (_) => ForgotPassword()
          )
        );
      },          
      child: Text(
        'Forgot password',
        style: TextStyle(
          color: Colors.blue, 
          fontSize: 15
        ),
      ),
    );
  }
}