class UserModel {
  String firstName;
  String lastName;
  String email;
  String gender;
  String password;
  String? location;
  UserModel({
    required this.firstName,
    required this.password,
    required this.email,
    required this.gender,
    required this.lastName,
    this.location,
  });

  toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'email': email,
        'location': location,
      };
}
