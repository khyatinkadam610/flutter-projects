import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/screens/authenticate/authenticate.dart';
import 'package:ninja_brew_crew/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:ninja_brew_crew/models/user.dart';

class wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user= Provider.of<User>(context);

    if(user == null)
    {
      return Authenticate();
    }else{
      return Home();
    }
    
  }
}