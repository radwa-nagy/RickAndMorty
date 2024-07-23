class Character {
  late int id;
  late String name;
  late String image;
  late String status;
  late String gender;
  late String species;

  Character.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    status = json["status"];
    gender = json["gender"];
    species = json["species"];
  }
}
