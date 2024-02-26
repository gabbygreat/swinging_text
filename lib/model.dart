import 'dart:convert';

class User {
    int id;
    String uid;
    String password;
    String firstName;
    String lastName;
    String username;
    String email;
    String avatar;
    String gender;
    String phoneNumber;
    String socialInsuranceNumber;
    DateTime dateOfBirth;

    User({
        required this.id,
        required this.uid,
        required this.password,
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.avatar,
        required this.gender,
        required this.phoneNumber,
        required this.socialInsuranceNumber,
        required this.dateOfBirth,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uid: json["uid"],
        password: json["password"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        avatar: json["avatar"],
        gender: json["gender"],
        phoneNumber: json["phone_number"],
        socialInsuranceNumber: json["social_insurance_number"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "avatar": avatar,
        "gender": gender,
        "phone_number": phoneNumber,
        "social_insurance_number": socialInsuranceNumber,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    };
}
