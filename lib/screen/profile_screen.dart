import 'package:dating_app/controller/userData.dart';
import 'package:dating_app/model/user.dart';
import 'package:dating_app/screen/edit_profile_screen.dart';
import 'package:dating_app/screen/login_screen.dart';
import 'package:dating_app/widget/banner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/cons.dart';

class ProfileScreen extends StatefulWidget {
  final String? phone;
  const ProfileScreen({super.key,this.phone});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isloading = true;

  User? data;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();

  }

    getData() async{

      setState(() {
        isloading = true;
      });

      if(widget.phone != null) {
        data = await Userdata().getUserData(widget.phone!);
      } else {
        data = await Userdata().myUserData();
      }

      setState(() {
        isloading = false;
      });

    }

 void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          TextButton(
            child: Text("Logout"),
            onPressed: () async{
              Navigator.of(context).pop(); 

              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(Constant.phone, '');

              Navigator.pushReplacement(
                context,MaterialPageRoute(builder: (context) => LoginScreen()),);
            },
          ),
        ],
      );
    },
  );
}






  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: widget.phone != null ? BackButton(color: Colors.white,) : null,
        title: Text("Profile",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pinkAccent,
        actions: widget.phone == null ? [
          IconButton(onPressed: () {

            if(data != null) {
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => EditProfileScreen(data: data!,)),).then((val) {
                  if(val == true) {
                    getData();
                  }
                });              
            }

          }, icon: Icon(Icons.edit,color: Colors.white,)),
          IconButton(onPressed: () {
            _showLogoutDialog(context);

          }, icon: Icon(Icons.logout,color: Colors.white,)),
        ] : [],
      ),
      body: isloading ? Center(child: CircularProgressIndicator(),) : 
      
      data == null ? Center(child: Text("Something went wrong"),) : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
          
                children: [
                  
                  /// banner
                  Container(
                    height: 270,
                    child: ImageBanner(
                      imageUrls: data!.photos,
                    )),
          
                    Divider(thickness: 2,),
          
                   
                    /// profile pic
                    CircleAvatar(
                     radius: 50,
                     backgroundImage: NetworkImage(data!.profilePic),
                     backgroundColor: Colors.white,
                    ),
          
          
                    /// name
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(data!.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                       if(data!.isVerified) Icon(Icons.verified,color:  Colors.blue)
                      ],
                    ),
          
                    ///sex and age
                    SizedBox(height: 5,),
                    Row(children: [
                      Text(data!.gender,style: TextStyle(fontSize: 16,),),
                      SizedBox(width: 14,),
                      Text(data!.age,style: TextStyle(fontSize: 16),)
                    ],),
          
          
                   /// Interest
                   SizedBox(height: 20,),
                   Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                    'Interests',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: data!.interests.map<Widget>((e) {
          
                    return InkWell(
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          gradient:  LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: [
                               Colors.pinkAccent,
                               Colors.pinkAccent
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Text(
                          "${e}",
                          style: TextStyle(
                            color: Colors.white ,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ), 
          
          
                  SizedBox(height: 20,),
                   Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                    'Bio',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
          
                Text(data!.bio,maxLines: 8,),

                SizedBox(height: 20,),
    
              ],),
        ),
      ),
    );
  }
}