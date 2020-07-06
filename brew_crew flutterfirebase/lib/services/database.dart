import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninja_brew_crew/models/brew.dart';
import 'package:ninja_brew_crew/models/user.dart';

class Databaseservices
{
//collection reference
final CollectionReference brewCollection =Firestore.instance.collection('brews');
final String uid;
Databaseservices({this.uid});
//update method
Future updateUserData (String sugars,String name,int strength )async
{
 return await brewCollection.document(uid).setData({
   'sugars':sugars,
   'name':name,
   'strength':strength
 });
}
List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot)
{
  return snapshot.documents.map((doc){
    return Brew(
      name:doc.data['name']??' ',
      sugar:doc.data['sugars']??'0',
      strength:doc.data['strength']??0,
    );
  }
  ).toList();
}

Stream <List<Brew>> get brews
{
  return brewCollection.snapshots()
  .map(_brewListFromSnapshot);
}


UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
{
  return UserData(
    uid:snapshot.data['uid'],
    name:snapshot.data['name'],
    sugar:snapshot.data['sugars'],
    strength:snapshot.data['strength'],
    
  );
}

Stream <UserData> get userData{
  return brewCollection.document(uid).snapshots()
  .map(_userDataFromSnapshot);
}
}