import 'package:ecommerce/pages/admin_side.dart';
import 'package:ecommerce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
          "Welcome FalanFilan",
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
                onPressed: signIn,
                child: Text("Sign In",style: TextStyle(color: Colors.yellow),),
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signIn() async{
    // Validate fields  , and login to firebas
    final formState = _formKey.currentState;
    if(formState.validate()){
      // now we can login to firebase
      formState.save();
      try{
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        if(user.email =="test@gmail.com"){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>Admin()));
        }else{
              Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage(user: user)));
        }
      }catch(e){
          print("deneme");
          
      }
    
    }
  }
  
}
