import 'package:flutter/material.dart';
import 'package:world_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  
  void getWorldtime() async
  {
    // creates a worldtime object from world_time.dart
    WorldTime instance=WorldTime(flag:'kolkatta.png',location:'Kolkatta',url:'Asia/Kolkata');
    await instance.getTime();
    Navigator.pushReplacementNamed(context,'/home' ,arguments: {
      'location':instance.location,
      'time':instance.time,
      'flag':instance.flag,
      'isDaytime':instance.isDaytime,
    });
  
  }
  @override
  void initState() {
    // execute during initialization
    super.initState();
    getWorldtime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child:Center(
          child:SpinKitWave(
          color: Colors.white,
          size: 50.0,
          ),

      )
      
      ),
    );
  }
}