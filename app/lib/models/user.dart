class User{
  String email;
  String username;
  String password;
  String password2;

  bool animationStatus=false;

  User({this.email, this.username, this.password, this.password2});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'], username: json['username'], password: json['password'], password2: json['password2']);
  }
  dynamic toJson() => {'email': email, 'username': username, 'password': password, 'password2': password2};
}