import "package:flutter/material.dart";
import 'package:ninja_brew_crew/models/brew.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:ninja_brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:ninja_brew_crew/screens/home/brewList.dart';
import 'package:ninja_brew_crew/screens/home/setting_form.dart';
class Home extends StatelessWidget {
  
  AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel()
    {
      showModalBottomSheet(context: context, builder:(context)
      {
        return Container(
          padding: EdgeInsets.symmetric(vertical:20,horizontal:60),
          child:SettingForm(),
        );
      });

    }

    return StreamProvider<List<Brew>>.value(
      value: Databaseservices().brews,
      child:Scaffold(
        
        backgroundColor:Colors.brown[50],
        appBar:AppBar(
          backgroundColor:Colors.brown[400],
          elevation: 0,
          title: Text("Brew Crew"),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: ()async{
                await _auth.signOut();
              }, 
              icon: Icon(Icons.person), 
              label: Text("LogOut"),
              ),
              FlatButton.icon(
              onPressed: ()=>_showSettingsPanel(),
              icon: Icon(Icons.settings), 
              label: Text("Settings"),
              )
          ],

        ),
        body: Container(
          decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage('lib/assets/coffee.jpg'),
              fit: BoxFit.cover
              )
          ),
          child: BrewList()
          ),
      ),
    );
  }
}