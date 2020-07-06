import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime
{
  WorldTime({this.flag,this.location,this.url});


  String location;
  String time;
  String flag; //for url to asset flag icon
  String url; //location for api 
  bool isDaytime;
  
  Future<void> getTime() async
  {
    try{
      Response response=await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);
    // print(data['utc_offset']);
    String datetime=data['datetime'];
    String offset=data['utc_offset'].substring(1,3);
    String offsetMin=data['utc_offset'].substring(4,6);
    
    // print(offset);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset),minutes: int.parse(offsetMin)));
    isDaytime=now.hour>6 && now.hour<20?true:false;
    // print(now);
    time=DateFormat.jm().format(now);//to convert DAtetime object to string
    // print(time);

    }catch(e)
    {
        print(e);
        time="counld not get time data";
    }
  }
}