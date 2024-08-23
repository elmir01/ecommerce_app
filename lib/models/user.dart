class User {
   int? id;
   String?  firstName;
   String? lastName;
   String? email;
   String password;
   String? imagePath;

  User({
    this.id,
    this.firstName,
    this.lastName,
    required this.email,
    required this.password,
     this.imagePath,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    imagePath: json["imagePath"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "imagePath": imagePath,
  };
}
