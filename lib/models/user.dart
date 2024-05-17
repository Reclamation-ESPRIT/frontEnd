class User {
  String? fullName, email, password;
  String? profilePicture;
  User({
    this.fullName,
    this.email,
    this.password,
    this.profilePicture,
  });

  // Encode the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "password": password,
      "profilePicture": profilePicture,
    };
  }

  // Decode JSON to object
  static User fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      profilePicture: json['profilePicture'],
    );
  }
}
