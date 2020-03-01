import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        
          iconTheme: IconThemeData(
            color: Colors.yellow, //change your color here
          ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Register Page",
          style: TextStyle(color: Colors.yellow),
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
                    style: TextStyle(color: Colors.white,
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
                      child: Icon(Icons.account_balance,color: Colors.white,),
                    ),
                  Text("Contact : ",style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),),
                  Text(
                    "fatihmercan7991@gmail.com",
                    textAlign: TextAlign.end,

                    style: TextStyle(
                      color: Colors.yellow,
                        fontWeight: FontWeight.w600,),
                  ),             
                ],
              ),
              
            ],
          ),

          height: 50,
        ),
        color: Colors.black,
      ),
      body: SingleChildScrollView(
          child: Form(
          key: _formKey,
          child: Column(         
            children: <Widget>[        
              Container(
                color: Colors.pink,
                height: 160, 
                width: 430,
                child:    Image.network("https://tinypng.com/images/social/page-analyzer.jpg",fit: BoxFit.cover,),
              ),    
              TextFormField(
                textAlign: TextAlign.center,
                validator: (input){
                  if(input.isEmpty){
                    return 'Please type an e mail';
                  }
                },
                onSaved:(input) => _email = input ,
                decoration: InputDecoration(               
                  labelText: 'Email',
                   enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.black),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                   ),  
                ),
                
              ),
              TextFormField(
                  textAlign: TextAlign.center,
                validator: (input){
                  if(input.length <6 ){
                    return 'Password can not be less then 6';
                  }
                },
                onSaved:(input) => _password = input ,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.black),   
                      ),  
              focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                   ),  
                    labelText: 'Password'
                    
                ),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signUp,
                child: Text("Register",style: TextStyle(color: Colors.yellow),),
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signUp() async{
    // Validate fields  , and login to firebas
    final formState = _formKey.currentState;
    if(formState.validate()){
      // now we can login to firebase
      formState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        // Display for the user that we sent an email
        user.sendEmailVerification();
        Navigator.of(context).pop();
      }catch(e){
          print("deneme");
      }
    
    }
  }
}