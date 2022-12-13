
class UserListModel {
  int? id;
  String? name;
  String? age;
  String? city;

  UserListModel({
    this.id,
    this.name,
    this.age,
    this.city,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json){
    return  UserListModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      city: json['city'],
    );
  }
}
