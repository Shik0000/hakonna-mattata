class UserModel {
  String User_id;
  String User_name;
  String email;
  String password;

  UserModel(this.User_id, this.User_name, this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'User_id': User_id,
      'User_name': User_name,
      'email': email,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    User_id = map['User_id'];
    User_name = map['User_name'];
    email = map['email'];
    password = map['password'];
  }
}
