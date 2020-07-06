import 'package:ninja_brew_crew/models/user.dart';
import 'package:ninja_brew_crew/services/database.dart';
import 'package:ninja_brew_crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey=GlobalKey<FormState>();
  final List <String> sugars= ['0','1','2','3','4'];
  String _currentsugar,_currentname;
  int _currentstrength;

  @override
  Widget build(BuildContext context) {
    final user= Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: Databaseservices(uid:user.uid ).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        { 
          UserData userdata=snapshot.data;
          return Form(
          key: _formkey,
          child: Column(
            children:<Widget>[
              Text(
                "Update your Brew Choices",
                style: TextStyle(
                  fontSize: 18,
                ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: userdata.name,
                  decoration:textinputdecoration,
                  validator:(val) => val.isEmpty?"Fill out the name field":null,
                  onChanged: (val){
                    setState(() {
                      _currentname=val;
                    });
                  },            
                ),
                SizedBox(height: 20,),
                //dropbox
                DropdownButtonFormField(
                  decoration: textinputdecoration   ,
                  value: _currentsugar ?? userdata.sugar,
                   onChanged: (val){
                    setState(() {
                      // print(userdata.sugar);
                      _currentsugar=val;
                    });
                  },
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
            
                      value: sugar,
                      child:Text('${sugar} sugar(s)')
                      );
                  } ).toList(),
                ),
                SizedBox(height: 20,),
                //slider
                Slider(
                  activeColor: Colors.brown[_currentstrength ?? userdata.strength],
                  inactiveColor:Colors.brown[_currentstrength ?? userdata.strength] ,
                  min: 100.0,
                  max: 900.0,
                  divisions:8,
                  value:(_currentstrength ?? userdata.strength).toDouble(),
                  onChanged: (val)=>setState(()=>_currentstrength=val.round()),
                  ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    "Update",
                    style: TextStyle(
                    color: Colors.white,
                    ),
                  ),
                  onPressed: () async
                  {
                    if(_formkey.currentState.validate())
                    {
                      await Databaseservices(uid: user.uid ).updateUserData(
                        _currentsugar?? userdata.sugar,
                        _currentname?? userdata.name,
                        _currentstrength ?? userdata.strength

                      );
                      Navigator.pop(context);
                    }
                  }
                  )   

            ],
          )
          
          );
        }else{
          return Loading();
        }
      }
    );
  }
}