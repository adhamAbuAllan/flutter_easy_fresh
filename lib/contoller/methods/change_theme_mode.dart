import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
class ChangeThemeMode extends GetxController {
   bool isLight = false;
 void onChanged(bool onChange )async{
   // SharedPrefer// Assuming ChangeThemeMode is a provider that holds theme data
   // final themeModeProvider = Provider<ChangeThemeMode>((ref) {
   //   return ChangeThemeMode();
   // });ences prefs! = await SharedPreferences.getInstance();
   debugPrint("the isDark value before change value is $isLight -> in onChange method");

   isLight =onChange;
    // sp.setBool('isDark', isDark);
   // prefs = await SharedPreferences.getInstance();

   // prefs.setBool('isDark', onChange);
   save(isLight);

   // debugPrint(onChange);
    update();
  }
   void save(bool value) async {
     debugPrint("the isDark value before save it value is $isLight -> in save method");
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool('isDark', value);
     debugPrint("the isDark value after save it value is $isLight -> in save method");

   }
   void loadValue() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
       debugPrint("the isDark value before load it value is $isLight -> in loadValue method");
       isLight = prefs.getBool('isDark') ?? false;
       debugPrint("the isDark value after load it value is $isLight -> in loadValue method");
       update();

   }


/*
void saveTotal(int totalValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('total', totalValue);
}

 */
}
