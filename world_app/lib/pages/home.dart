import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};

  @override
  Widget build(BuildContext context) {
    data=data.isNotEmpty? data:ModalRoute.of(context).settings.arguments;
    // print(data);
    String bgImage=data['isDaytime']?'day.png':'night.png';
    Color fncolor;
     Color bgcolor; 
    fncolor=data['isDaytime']?Colors.black:Colors.white;
    bgcolor=data['isDaytime']?Colors.lightBlue:Colors.black;
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Container(
           decoration: BoxDecoration(
                    // border: Border.all(color:fncolor),
                    image:DecorationImage(
                      image:AssetImage('assets/$bgImage'),
                      fit: BoxFit.cover,
                      
                      )
                     ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120,0,0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                FlatButton.icon(
                  onPressed: ()async{
                   dynamic result= await Navigator.pushNamed(context, '/location');
                   setState(() {
                    data={
                      'time':result['time'],
                      'location':result['location'],
                      'isDaytime':result['isDaytime'],
                      'flag':result['flag'],
                    };   
                   });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color:fncolor,
                  ), 
                  label: Text(
                    data['location'],
                    style: TextStyle(
                      color: fncolor,
                    ),
                    ),
                  // color: fncolor,
                  ),
                  SizedBox(height:20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        color: fncolor,
                        fontSize: 28,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20),
                Text(
                    data['time'],
                    style: TextStyle(
                        color: fncolor,
                        fontSize: 45,
                        letterSpacing: 2,
                      ),
                    ),
                SizedBox(height:20),
                Container(
                  
                 
                )  
              ]
            ),
          ),
        ),
      
      ),
    );
  }
}