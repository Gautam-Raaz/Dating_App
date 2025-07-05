import 'package:dating_app/controller/userData.dart';
import 'package:dating_app/model/user.dart';
import 'package:dating_app/widget/userCard.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<User> allData = [];

  TextEditingController search = TextEditingController();

  List<User> filterData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();

  }

    getData() async{
      allData = await Userdata().getallUsers();
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Search",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
            children: [
          
                Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      onChanged: (value) {

                        setState(() {
                             filterData.clear();

                        });
        
                   if(search.text.trim().isNotEmpty) {
        
                      setState(() {
        
        
                          if(value.isNotEmpty) {
        
                            allData.forEach((data) {
        
                              if(data.name.toLowerCase().contains(value.toLowerCase())) {
        
                                setState(() {
                                   filterData.add(data);
                                });
                              }
                            });
        
                          }
                          
                        });
        
                   }                     
                },
                      controller: search,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter user name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: InkWell(
                            onTap: () {
                            },
                            child: Icon( Icons.search,color: Colors.black,),
                          )
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
        
                  SizedBox(height: 10,),

                  Expanded(
                    child: Container(
                      child: filterData.isEmpty ? Center(child: Text("No Users found"),) :  
                      
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
                        isHome: false,
                        isMatch: false,
                        data: filterData[index],
                        like: (val) {},
                       
                                );
                      },),
                    ),
                  ),

          ],),
    );
  }
}