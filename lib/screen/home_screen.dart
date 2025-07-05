import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/userData.dart';
import 'package:dating_app/model/user.dart';
import 'package:dating_app/screen/filter_screen.dart';
import 'package:dating_app/screen/match.dart';
import 'package:dating_app/widget/userCard.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<User> filterData = [];

  bool isloading = true;

  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();

  }

  getData() async {
    filterData = await Userdata().getFilteredUsers();
    setState(() {
      isloading = false;
    });
  }

    void showSnack(String text) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(onPressed: () {

           Navigator.push(
                context,MaterialPageRoute(builder: (context) => FilterScreen()),).then((val) {
                  if(val == true) getData();
                });

          }, icon: Icon(Icons.filter_list,color: Colors.white,))
        ],
      ),
      body: isloading ? Center(child: CircularProgressIndicator(),) : 
      
      filterData.length == 0 ? Center(child: Text("No Match found"),) :


          GridView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  shrinkWrap: false,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2,
                           mainAxisSpacing: 15,
                           crossAxisSpacing: 10
                           
                           ),
                  itemCount: filterData.length,
                  itemBuilder: (context , index) {
                  return Usercard(
                    data: filterData[index],
                    isHome: true,
                    isMatch: false,
                    like: (val) async{

                      if(val) {

                       Userdata().updatefilterUserData({
                          'liked': FieldValue.arrayUnion([filterData[index].phoneNumber])
                          }
                       );

                       bool isMatch = await Userdata().checkliked(filterData[index].phoneNumber);

                  if(isMatch) {
                    User? data = await Userdata().myUserData();
                    String temp = filterData[index].profilePic;

                    print(temp);
                     Navigator.push(
                          context,
                        PageRouteBuilder(
                          opaque: false,
                         pageBuilder: (_, __, ___) => MatchGIFAnimation(
                          user1Url: temp,
                          user2Url: data!.profilePic,
                          onDone: () {
                          Navigator.pop(context);
                       }),
                     ),
                  );
                            
                       }
                        
                      } else {

                      Userdata().updatefilterUserData({
                          'disliked': FieldValue.arrayUnion([filterData[index].phoneNumber])
                          }
                       );

                      }


                    showSnack(
                        "${val ? "Liked" : "Disliked"} ${filterData[index].name} sucessfully"
                      );
                      setState(() {
                        filterData.removeAt(index);
                      });
                  },
                 );
           },),
    );
  }
}
