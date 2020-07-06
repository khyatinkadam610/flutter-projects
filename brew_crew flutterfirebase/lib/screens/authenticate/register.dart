import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:ninja_brew_crew/shared/constants.dart';
import 'package:ninja_brew_crew/shared/loading.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email=' ',password=' ',error=' ';
  bool loading=false;
  final AuthServices _auth = AuthServices();
  final _formKeys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor:Colors.brown[400],
        elevation: 0.0,
        title:Text("Sign up to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            }, 
            icon: Icon(Icons.person), 
            label: Text("SignIn")
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
                validator: (val)=>val.length<6 ?"password less than 6" : null,
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
                  setState(() {
                    loading=false;
                  });
                  if(_formKeys.currentState.validate())
                  {
                    dynamic result= await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null)
                    {
                        setState((){
                          error="Please enter valid email";
                          loading=true;
                          });
                    }
                  }
                } ,
                child: Text("Register"),
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