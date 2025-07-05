class User {
  String name;
  bool isVerified;
  String phoneNumber;
  String password;
  String joiningDate;
  String profilePic;
  List<String> photos;
  DateTime dob;
  List<String> interests;
  String gender;
  String bio;
  String age;




  User({
    required this.name,
    required this.isVerified,
    required this.phoneNumber,
    required this.password,
    required this.joiningDate,
    required this.profilePic,
    required this.photos,
    required this.dob,
    required this.interests,
    required this.gender,
    required this.bio,
    required this.age
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        name: json["name"],
        isVerified: json["isVerified"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        joiningDate: json["joiningDate"],
        profilePic: json["profilePic"],
        photos: (json['photos'] as List<dynamic>?)
           ?.map((item) => item.toString())
           .toList() ?? [],
        dob: json["dob"].toDate(),
        interests: (json['interests'] as List<dynamic>?)
           ?.map((item) => item.toString())
           .toList() ?? [],
        gender: json["gender"],
        bio: json["bio"],
        age: json["age"]
        

      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "isVerified": isVerified,
    "phoneNumber": phoneNumber,
    "password": password,
    "joiningDate": joiningDate,
    "profilePic": profilePic,
    "photos": photos,
    "dob": dob,
    "interests": interests,
    "gender": gender,
    "bio": bio,
    "age": age
  };


}