import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/userData.dart';
import 'package:dating_app/model/user.dart';
import 'package:dating_app/widget/userCard.dart';
import 'package:flutter/material.dart';

class AllMatch extends StatefulWidget {
  const AllMatch({super.key});

  @override
  State<AllMatch> createState() => _AllMatchState();
}

class _AllMatchState extends State<AllMatch> {

  List<User> likedUsers = [];
  List<User> dislikedUsers = [];
  List<User> matchUsers = [];


  bool isloading = true;

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

     likedUsers = await Userdata().getlikedUsers();
     dislikedUsers = await Userdata().getdislikedUsers();
     matchUsers = await Userdata().getMatchUsers();

    setState(() {
      isloading = false;
    });

  }

  void showSnack(String text) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  }

  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Match",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pinkAccent,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(child: Text("Liked Users",style: TextStyle(color: Colors.white),),),
              Tab(child: Text("Disliked Users",style: TextStyle(color: Colors.white),),),
              Tab(child: Text("Matches Users",style: TextStyle(color: Colors.white),),)
            ],
          ),
        ),
        body: isloading ? Center(child: CircularProgressIndicator(),) :  TabBarView(
          children: <Widget>[
            like(),
            dislike(),
            match(),
            
          ],
        ),
      ),
    );
  }

  Widget like() {
    return likedUsers.isEmpty ? Center(child: Text("No Data"),) : 
                 GridView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      shrinkWrap: false,
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2,
                               mainAxisSpacing: 15,
                               crossAxisSpacing: 10
                               
                               ),
                      itemCount: likedUsers.length,
                      itemBuilder: (context , index) {
                      return Usercard(
                        isHome: false,
                        isMatch: true,
                        data: likedUsers[index],
                        like: (val) async{
                          bool success = await Userdata().updatefilterUserData({
                            'liked': FieldValue.arrayRemove([likedUsers[index].phoneNumber])
                          });

                          if(success) {
                      showSnack(
                        "${likedUsers[index].name} remove sucessfully"
                      );

                      getData();


                       }
                        },
                        );
                      },);
  }


   Widget dislike() {
    return dislikedUsers.isEmpty ? Center(child: Text("No Data"),) : 
                 GridView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      shrinkWrap: false,
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2,
                               mainAxisSpacing: 15,
                               crossAxisSpacing: 10
                               
                               ),
                      itemCount: dislikedUsers.length,
                      itemBuilder: (context , index) {
                      return Usercard(
                        isHome: false,
                        isMatch: true,
                        data: dislikedUsers[index],
                        like: (val) async{
                          bool success = await Userdata().updatefilterUserData({
                            'disliked': FieldValue.arrayRemove([dislikedUsers[index].phoneNumber])
                          });

                          if(success) {
                      showSnack(
                        "${dislikedUsers[index].name} remove sucessfully"
                      );

                      getData();


                       }                          



                        },
                        );
                      },);
  }

   Widget match() {
    return matchUsers.isEmpty ? Center(child: Text("No Data"),) : 
                 GridView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      shrinkWrap: false,
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2,
                               mainAxisSpacing: 15,
                               crossAxisSpacing: 10
                               
                               ),
                      itemCount: matchUsers.length,
                      itemBuilder: (context , index) {
                      return Usercard(
                        isHome: false,
                        isMatch: true,
                        data: matchUsers[index],
                        like: (val) async{
                           bool success = await Userdata().updatefilterUserData({
                            'liked': FieldValue.arrayRemove([matchUsers[index].phoneNumber])
                          });

                          if(success) {
                      showSnack(
                        "${matchUsers[index].name} remove sucessfully"
                      );

                      getData();


                       }                         
                        },
                        );
                      },);
  }
}