import 'package:flutter/material.dart';
import 'package:world_app/services/world_time.dart';

class Chooselocation extends StatefulWidget {
  @override
  _ChooselocationState createState() => _ChooselocationState();
}

class _ChooselocationState extends State<Chooselocation> {
    List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(flag:'kolkatta.png',location:'Kolkatta',url:'Asia/Kolkata'),
  ];

  void updateTime(index) async
  {
   WorldTime instance=locations[index];
    await instance.getTime();
    // navigate to home screen
    Navigator.pop(context,{
      'location':instance.location,
      'time':instance.time,
      'flag':instance.flag,
      'isDaytime':instance.isDaytime,
    }) ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title:Text('Choose Location'),
        backgroundColor:Colors.blue,
        centerTitle:true,
      ),
      body:ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context,index)
        {
          return Card(
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal:1.0,vertical: 2),
              child: ListTile(
                onTap:(){
                  updateTime(index);
                  // print(locations[index].location);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                backgroundImage:AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            )
          );
        }
      )
          );
  }
}