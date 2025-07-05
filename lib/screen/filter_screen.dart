import 'package:dating_app/controller/userData.dart';
import 'package:dating_app/model/filter.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  FilterUser? data;

  bool isloading = true;

List<String> genders = [
  "Male",
  "Female",
  "Non-binary",
  "Transgender",
  "Genderqueer",
  "Genderfluid",
  "Agender",
];

List<String> interestsCommon = [
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
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();

  }

  getData() async{
    
    data = await Userdata().getFilterData();

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Filter Users",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pinkAccent,
      ),
      body: isloading ? Center(child: CircularProgressIndicator(),) : 
      
      data == null ? Center(child: Text("Something went wrong"),) :

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(

              children: [
          
        
                  // Age Range
                  SizedBox(height: 20,),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Select Age range you want',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                RangeSlider(
                  values: RangeValues(double.parse(data!.minAge), double.parse(data!.maxAge)),
                   onChanged: (val) {
                    setState(() {
                      data!.minAge = val.start.toInt().toString();
                      data!.maxAge = val.end.toInt().toString();
                    });
                   },
                   divisions: 42,
                   min: 18,
                   max: 60,
                   labels: RangeLabels(data!.minAge , data!.minAge),
                   ),
        
        
                  // Age Range
                  SizedBox(height: 20,),
        
                  CheckboxListTile(
                  title: Text("Show only verified users only",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                   checkColor: Colors.white,
                   activeColor: Colors.pinkAccent,
                   value: data!.onlyVerified,
                   contentPadding: EdgeInsets.symmetric(horizontal: 0.0), // reduce gap
                   controlAffinity: ListTileControlAffinity.leading,
                  visualDensity: VisualDensity(horizontal: -3, vertical: -3), // reduce spacing vertically and horizontally
        
                   onChanged: (bool? value) {
                        setState(() {
                          data!.onlyVerified = value!;
                           });
                        },
                   ),
        
        
                  // Looking for
                  SizedBox(height: 20,),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Looking for',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: genders.map<Widget>((e) {
        
                    return InkWell(
                      onTap: () {
                  
                          setState(() {
                          data!.sex.contains(e) ? data!.sex.remove(e) : data!.sex.add(e);
                        });
        
                      },
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          gradient:  LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: [
                              data!.sex.contains(e) ? Colors.pinkAccent : Colors.grey,
                              data!.sex.contains(e) ? Colors.pinkAccent : Colors.blueGrey,
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
        
        
                 // Common Interests 
                  SizedBox(height: 20,),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Common Interest',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: interestsCommon.map<Widget>((e) {
        
                    return InkWell(
                      onTap: () {
                  
                          setState(() {
                          data!.mustInterest.contains(e) ? data!.mustInterest.remove(e) : data!.mustInterest.add(e);
                        });
        
                      },
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          gradient:  LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: [
                              data!.mustInterest.contains(e) ? Colors.pinkAccent : Colors.grey,
                              data!.mustInterest.contains(e) ? Colors.pinkAccent : Colors.blueGrey,
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
        
                SizedBox(height: 30,),
        
               Center(
                  child: InkWell(
                    onTap: () async{

                      if(data!.sex.isEmpty) {
                        showSnack("Please select atleast one gender you are looking for");
                      } else if(data!.mustInterest.length < 5) {
                         showSnack("Please select atleast 5 interest you are looking for");
                      } else {


                        setState(() {
                          isloading = true;
                        });



                        bool sucess = await Userdata().updatefilterUserData(data!.toJson());

                        if(sucess) {
                              setState(() {
                                isloading = false;
                              });
                                                            
                             showSnack("Filter data updated successfully");

                             Navigator.pop(context,true);
                        } else {
                          
                               setState(() {
                                isloading = false;
                              });
                                                            
                             showSnack("Something went wrong");                         
                        }

                     




                      }
                      
        
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text("Update filter",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                      ),
                   
                    ),
                  ),
                ),
        
        
        
                SizedBox(height: 50,),
        
        
              ],
            ),
        ),
      ),


      

    );
  }
}
