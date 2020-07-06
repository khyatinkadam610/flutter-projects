import 'package:firebase_auth/firebase_auth.dart';
import 'package:ninja_brew_crew/models/user.dart';
import 'package:ninja_brew_crew/services/database.dart';
class AuthServices{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  //user object based ob firebase object
  User _userFromFirebaseUser(FirebaseUser user)
  {
    return user != null?User(uid: user.uid) : null;
  }

  // Seting up Stream and convert it into user object
  Stream <User> get user{
    return _auth.onAuthStateChanged
    // .map((FirebaseUser user)=> _userFromForebaseUser(user));
    .map(_userFromFirebaseUser);
  }
  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result =await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      // print(user.email);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in with email and pass word
  Future signInWithEmailAndPassword(String email, String password) async
  {
    try
    {
      AuthResult result=await _auth.signInWithEmailAndPassword(email:email, password: password);
      FirebaseUser user = result.user;
      return  _userFromFirebaseUser(user);

    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  //register with email
  Future registerWithEmailAndPassword(String email, String password) async
  {
    try
    {
      AuthResult result=await _auth.createUserWithEmailAndPassword(email:email, password: password);
      FirebaseUser user = result.user;
      await Databaseservices(uid:user.uid).updateUserData('0','name', 100);
      return  _userFromFirebaseUser(user);

    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  //sign out
  Future signOut() async
  {
    try{

      return await _auth.signOut();
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
}