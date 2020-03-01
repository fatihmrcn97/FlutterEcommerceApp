import 'package:flutter/material.dart';
import 'package:ecommerce/pages/sign_up.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow,
        title: Text(
          "Welcome FalanFilan",
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "This app builded by Fatih Mercan",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),
                  ),             
                ],
              ),
              SizedBox(height: 10,),
              
                 Row(
                   
                   mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 135),
                      child: Icon(Icons.account_balance,),
                    ),
                  Text("Contact : ",style: TextStyle(
                        fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),),
                  Text(
                    "fatihmercan7991@gmail.com",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,),
                  ),             
                ],
              ),
              
            ],
          ),

          height: 50,
        ),
        color: Colors.yellow,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: navigateToSignIn,
            child: Text("🅛🅞🅖🅘🅝"),
            color: Colors.yellow,
          ),
          Container(
            height: 200,
            child: Image.network("https://tinyjpg.com/images/social/website.jpg"),
          ),
          RaisedButton(
            onPressed: navigateToSignUp,
            child: Text("🅡🅔🅖🅘🅢🅣🅔🅡"),
                color: Colors.yellow,
          ),
        ],
      ),
    );
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Login(), fullscreenDialog: true));
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUp(), fullscreenDialog: true));
  }
}
