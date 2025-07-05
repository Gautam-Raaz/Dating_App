import 'package:dating_app/model/user.dart';
import 'package:dating_app/screen/profile_screen.dart';
import 'package:flutter/material.dart';

class Usercard extends StatelessWidget {
  final User data;
  final void Function(bool isLiked) like;
  final bool isHome;
  final bool isMatch;

  const Usercard({super.key,required this.data, required this.like,required this.isHome,required this.isMatch});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 237, 222, 227),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                 Navigator.push(
                context,MaterialPageRoute(builder: (context) => ProfileScreen(phone: data.phoneNumber,)),);
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: NetworkImage(data.profilePic),fit: BoxFit.cover)
                ),
              ),
            ),
      
            SizedBox(height: 5,),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                      children: [
                        Text(data.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                       if(data.isVerified) Icon(Icons.verified,color:  Colors.blue )
                      ],
                    ),
            ),
      
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  Text(data.gender,style: TextStyle(fontSize: 15,),),
                  SizedBox(width: 15,),
      
                  Text(data.age,style: TextStyle(fontSize: 15,),),
      
                ],
              ),
            ),

            SizedBox(height: 5,),

          if(isHome)

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [

                GestureDetector(
                  onTap: () => like(true),
                  child:  Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("like",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                ),),

                  GestureDetector(
                    onTap: () => like(false),
                  child:  Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)

                  ),
                   child: Center(child: Text("dislike",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),),

                ),
              ) 

                

            ],),


            if(isMatch) Center(
              child: GestureDetector(
                onTap: () => like(true),
                child: Container(
                  height: 20,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(14)
                  ),
                  child: Center(child: Text('Remove',style: TextStyle(color: Colors.white),),),
                ),
              ),
            )
          ],
        ),
    );
  }
}