import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:ninja_brew_crew/shared/constants.dart';
import 'package:ninja_brew_crew/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKeys = GlobalKey<FormState>();
  String email=' ',password=' ',error=" ";
  bool loading=false;

 
  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor:Colors.brown[400],
        elevation: 0.0,
        title:Text("Sign in to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            }, 
            icon: Icon(Icons.person), 
            label: Text("Register")
            )
        ],
      ),
      body:Container(
        
        padding: EdgeInsets.symmetric(vertical:20,horizontal:50),
        child:Form(
          key: _formKeys,
          child:Column(
            children:<Widget>[
              SizedBox(height:20),
              TextFormField(
                decoration: textinputdecoration.copyWith(hintText:"Email"),
                validator: (val)=>val.isEmpty ? "Form field empty" :null,
                onChanged:(val)
                {
                  email=val;
                }
                ),
              SizedBox(height:20),
              TextFormField(
                decoration: textinputdecoration.copyWith(hintText:"Password"),
                validator: (val)=>val.length<6 ?"password lenght must be more than 6":null,
                obscureText: true,
                onChanged:(val)
                {
                  password= val;
                }
                ),
              SizedBox(height:20),
              RaisedButton(
                color: Colors.pink[400],
                onPressed:() async
                {
                  if(_formKeys.currentState.validate())
                  {
                    setState(() {
                      loading=true;
                    }); 
                    dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null)
                    {
                        setState((){
                          error="Please enter valid email or password";
                          loading=false;
                        });
                    }
                  }
                },
                child: Text("SignIn"),
                ),
                SizedBox(height:12),
                Text(
                  error,
                  style: TextStyle(
                    color:Colors.red,
                    fontSize: 14,
                  ),
                  ),

            ]
          ) 
        
        
        )       
      )
    );
  }
}