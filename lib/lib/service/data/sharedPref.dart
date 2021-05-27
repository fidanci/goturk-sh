import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
final prefs = SharedPreferences.getInstance();
  
Future<void> saveToken(String token)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);

}
Future<void> saveID(String token)async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("id", token);

}
Future<String> getToken()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
 var token = prefs.getString("token");
 return token;
}
Future<String> getID()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
 var token = prefs.getString("id");
 return token;
}
Future<bool> isLoged()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");
  if(token == "0"){
    return false;
  }else{
    return true;
  }
}

Future<bool> clear()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("id");

}
}