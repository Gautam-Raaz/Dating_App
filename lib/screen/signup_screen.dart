import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constant/cons.dart';
import 'package:dating_app/controller/auth.dart';
import 'package:dating_app/model/filter.dart';
import 'package:dating_app/model/user.dart';
import 'package:dating_app/screen/dashboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignupScreen extends StatefulWidget {
   SignupScreen({super.key, });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {



  String name = "";
  String phoneNumber = "";
  String email = "";
  String password = "";
  String profilePic = "";
  bool isloading = false;
  bool isHidden = true;
  String bio = "";

  List<String> photos = [

  ];
  String selGender = "Male";
  
  List<String> genders = [
  "Male",
  "Female",
  "Non-binary",
  "Transgender",
  "Genderqueer",
  "Genderfluid",
  "Agender",
];


List<String> interests = [
  // Lifestyle & Hobbies
  "Traveling",
  "Cooking",
  "Reading",
  "Fitness",
  // "Hiking",
  // "Yoga",
  "Biking",
  "Photography",
  "Gardening",
  // "DIY & Crafts",

  // Entertainment
  "Music",
  "Movies",
  // "TV Shows",
  // "Anime",
  // "K-Pop",
  // "Gaming",
  // "Theatre",
  // "Stand-up Comedy",
  // "Podcasts",
  "Dancing",

  // Tech & Creativity
  // "Coding",
  // "AI & Machine Learning",
  // "Startups",
  // "Graphic Design",
  // "Blogging",
  // "Content Creation",
  // "Crypto & Web3",
  // "UI/UX Design",
  // "3D Modeling",
  // "Writing",

  // Personal Development
  "Meditation",
  // "Journaling",
  // "Public Speaking",
  // "Learning Languages",
  // "Investing",
  // "Philosophy",
  // "Psychology",
  // "Mindfulness",
  // "Volunteering",
  // "Time Management",

  // Food & Drink
  "Coffee Lover",
  "Tea Enthusiast",
  "Street Food",
  "Wine Tasting",
  // "Baking",
  // "Vegan Lifestyle",
  // "Foodie",
  // "Craft Beer",
  // "BBQ",
  // "Fine Dining",

  // Animals & Nature
  "Pet Lover",
  "Nature Walks",
  // "Wildlife Photography",
  // "Marine Life",
  // "Birdwatching",
  "Eco-Friendly Living",

  // Sports & Games
  "Football",
  "Cricket",
  // "Basketball",
  // "Running",
  // "Chess",
  // "Board Games",
  // "Pool",
  // "Badminton",
  // "Tennis",
  // "Adventure Sports"
];

List<String> selInterest = [];



int calculateAge(DateTime birthDate) {
  DateTime today = DateTime.now();

  int age = today.year - birthDate.year;

  // Check if birthday has not occurred yet this year
  if (today.month < birthDate.month || 
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}


  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // default date
      firstDate: DateTime(2000),   // earliest date
      lastDate: DateTime(2100),    // latest date
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void showSnack(String text) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        title: Text("SignUp",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: isloading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [

              // profile pic
              SizedBox(height: 20,),
              InkWell(
                onTap: () {

                  ImagePicker()
                      .pickImage(
                      source: ImageSource.gallery, imageQuality: 100)
                      .then((value) {

                    if(value != null) {
                      setState(() {
                        profilePic = value.path;
                      });
                    }

                  });
                },
                child: ClipOval(
                  child: profilePic.isEmpty
                      ? Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[300],
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.person,size: 50,color: Colors.white,),

                      ],
                    ),
                  )
                      : Image(
                    image: FileImage(
                      File(profilePic),
                    ),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                ),
              ),

              // name
              SizedBox(height: 20,),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Profile Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
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
                    name = value;
                  },
                  controller: TextEditingController(text: name),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),

             

              // phoneNumber
              SizedBox(height: 20,),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
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
                    phoneNumber = value;
                  },
                  controller: TextEditingController(text: phoneNumber),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("+91"),
                      ],
                    )
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),

 
              // Interested
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
                children: interests.map<Widget>((e) {

                  return InkWell(
                    onTap: () {
                
                        setState(() {
                        selInterest.contains(e) ? selInterest.remove(e) : selInterest.add(e);
                      });

                    },
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        gradient:  LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: [
                            selInterest.contains(e) ? Colors.pinkAccent : Colors.grey,
                            selInterest.contains(e) ? Colors.pinkAccent : Colors.blueGrey,
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

              // Gender
              SizedBox(height: 20,),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Gender',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200],
                ),
                child:  DropdownButton<String>(
                  isExpanded: true,
                  value: selGender,
                 items: genders.map((String value) {
                 return DropdownMenuItem<String>(
                         value: value,
                         child: Text(value,style: TextStyle(color: Colors.black),),
                        );
                     }).toList(),
                onChanged: (val) {
                  setState(() {
                    selGender = val!;
                  });
                },
               ),
              ),


          

               // Date of birth
              SizedBox(height: 20,),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Select your Date of Birth',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

               GestureDetector(
                onTap: () {
                  _pickDate();
                },
                 child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[200],
                  ),
                  child:  Center(
                    child: Text(  _selectedDate == null
                          ? 'No date selected'
                            : '${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  )
                 ),
               ),


              // Bio
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
              Container(
                height: 130,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  onChanged: (value) {
                    bio = value;
                  },
                  controller: TextEditingController(text: bio),
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write something about yourself',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),

              // Photos
              SizedBox(height: 20,),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Pick Photo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Container(
                height: 350,
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: false,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 3),
                  itemCount: min(photos.length + 1,8),
                  itemBuilder: (context , index) {
                  return ((photos.length < 8) && (index == photos.length)) ? 
                  GestureDetector(
                    onTap: () {
                  ImagePicker()
                      .pickImage(
                      source: ImageSource.gallery, imageQuality: 100)
                      .then((value) {

                    if(value != null) {
                      setState(() {
                        photos.add(value.path);
                      });
                    }

                  });
                    },
                    child: Card(
                     child: GridTile(
                     child: Center(
                      child: Icon(Icons.photo,size: 34,),
                     ), //just for testing, will fill with image later
                          ),
                      ),
                  ) : 
                 Card(
                   child: GridTile(
                    footer: GestureDetector(
                      onTap: () {
                        setState(() {
                          photos.removeAt(index);
                        });
                      },
                      child: Container(
                        color: Colors.red,
                        child: Center(child: Text("Remove",style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                   child: Image(image: FileImage(File(photos[index])),fit: BoxFit.cover,), //just for testing, will fill with image later
                 ),
                );
                },),
              ),

            


              // password
              SizedBox(height: 20,),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Password',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
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
                    password = value;
                  },
                  controller: TextEditingController(text: password),
                  obscureText: isHidden,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                        child: Icon( isHidden ? Icons.visibility_off : Icons.visibility,color: Colors.black,),
                      )
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 30,),

             Center(
                child: InkWell(
                  onTap: () async{

                    if(profilePic.isEmpty) {
                      showSnack("Please upload your profile pic");
                    } else if(name.replaceAll(" ",'').length < 5) {
                      showSnack("Name must be minimum 5 character");
                    } else if(phoneNumber.isEmpty) {
                      showSnack("Please Enter phone number");
                    } else if(selInterest.length < 3) {
                      showSnack("Please Select atleast 3 interests");
                    } else if(_selectedDate == null) {
                       showSnack("Please Select your Date of birth");
                    } else if(calculateAge(_selectedDate!) < 18) {
                       showSnack("User must be atleast 18 years");
                    } else if(bio.replaceAll(' ', '').isEmpty) {
                      showSnack("Please Enter your Bio");
                    } else if (photos.length < 3) {
                      showSnack("Please Select atleast your 3 pic");
                    }  else if(password.isEmpty) {
                      showSnack("Please Enter password");
                    }  else if(password.replaceAll(' ', '').length < 8) {
                      showSnack("Please Enter password of atleast 8 digit");
                    } else if(phoneNumber.replaceAll(' ', '').length != 10) {
                      showSnack("Please Enter Correct phone number");
                    } else {
                    phoneNumber = phoneNumber.trim();

                      setState(() {
                        isloading = true;
                      });

                     
                        await FirebaseFirestore.instance.collection(
                            Constant.userTable).doc(phoneNumber).get().then((
                            doc) async {
                          if (doc.exists) {
                            showSnack("Phone Number already exists");
                            setState(() {
                              isloading = false;
                            });
                          } else {
                            final storageRef = FirebaseStorage.instance.ref();

                            final profile = storageRef.child(
                                "dating_app/profile_img/${phoneNumber}_prof.jpg");

                            List photo = []; 

                            for(int i = 0 ; i < photos.length ; i++) {

                              photo.add(storageRef.child(
                                "dating_app/photos/${phoneNumber}/${i}_photo.jpg"));

                            }



                            try {
                              await profile.putFile(File(profilePic));

                              String profileUrl = await profile
                                  .getDownloadURL();

                              List<String> photosUpload = [];

                              for(int i = 0; i < photo.length ; i++) {

                               await photo[i].putFile(File(photos[i]));

                              String Url = await photo[i]
                                  .getDownloadURL(); 


                                  photosUpload.add(Url);

                              }

                                  

                               var data = User(
                                name: name,
                                isVerified: false,
                                phoneNumber: phoneNumber,
                                password: password,
                                joiningDate: DateTime.now().toString(),
                                photos: photosUpload,
                                profilePic: profileUrl,
                                dob: _selectedDate!,
                                interests: selInterest,
                                gender: selGender,
                                bio: bio,
                                age: calculateAge(_selectedDate!).toString()
                               );

                               var filter = FilterUser(
                                maxAge: "60",
                                minAge: "18",
                                onlyVerified: false,
                                mustInterest: interests,
                                liked: [],
                                disliked: [],
                                sex: genders

                               );

                             bool sucess = await Auth().signUp(data,filter);

                             if(sucess) {
                                setState(() {
                                isloading = false;
                              });
                                                            
                          showSnack("SignUp Successfuly");

                           final SharedPreferences prefs = await SharedPreferences.getInstance();
                           await prefs.setString(Constant.phone, phoneNumber);

                           Navigator.pushReplacement(
                             context,MaterialPageRoute(builder: (context) => Dashboard()),);
                              
                             } else {

                              setState(() {
                                isloading = false;
                              });

                               showSnack("Some error happen");
                             
                             }



                            } catch (e) {
                              showSnack("Something went wrong");
                              setState(() {
                                isloading = false;
                              });
                            }
                          }
                        }
                      );
                      
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 180,
                    child: Center(
                      child: Text("Sign Up",style: TextStyle(color: Colors.white),),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),



              SizedBox(height: 30,),





            ],
          ),
        ),
      ),
    );
  }
}
