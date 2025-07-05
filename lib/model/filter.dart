class FilterUser {
  String maxAge;
  String minAge;
  bool onlyVerified;
  List<String> mustInterest;
  List<String> liked;
  List<String> disliked;
  List<String> sex;


  FilterUser({
    required this.maxAge,
    required this.minAge,
    required this.onlyVerified,
    required this.mustInterest,
    required this.liked,
    required this.disliked,
    required this.sex,
  });

  factory FilterUser.fromJson(Map<String, dynamic> json) {
     return FilterUser(
        maxAge: json["maxAge"],
        minAge: json["minAge"],
        onlyVerified: json["onlyVerified"],
        mustInterest: (json['mustInterest'] as List<dynamic>?)
           ?.map((item) => item.toString())
           .toList() ?? [],
        liked: (json['liked'] as List<dynamic>?)
           ?.map((item) => item.toString())
           .toList() ?? [],
        disliked: (json['disliked'] as List<dynamic>?)
           ?.map((item) => item.toString())
           .toList() ?? [],
        sex: (json['sex'] as List<dynamic>?)
           ?.map((item) => item.toString())
           .toList() ?? [] 
      );
  }

  Map<String, dynamic> toJson() => {
    "maxAge": maxAge,
    "minAge": minAge,
    "onlyVerified": onlyVerified,
    "mustInterest": mustInterest,
    "liked": liked,
    "disliked": disliked,
    "sex": sex,
  };


}