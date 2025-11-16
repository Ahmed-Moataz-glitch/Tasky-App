class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) : this(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
  );
  
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }
}
