import 'package:dating_app/constant/cons.dart';
import 'package:dating_app/screen/dashboard.dart';
import 'package:dating_app/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),() {
      nevigate();
    });
  }

  nevigate() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? phone = prefs.getString(Constant.phone);

    if(phone == null || phone == ''|| phone.length != 10) {

         Navigator.pushReplacement(
          context,MaterialPageRoute(builder: (context) => LoginScreen()),);

    } else {
       Navigator.pushReplacement(
          context,MaterialPageRoute(builder: (context) => Dashboard()),);
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      backgroundColor: Colors.white,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Image.asset("assets/splash.png")
            
          
          ],
        ),
      ),
    );
  }
}
