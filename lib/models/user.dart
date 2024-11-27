import 'package:animated_custom_dropdown/custom_dropdown.dart';

class User with CustomDropdownListFilter {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  //? Allows this object to be searchable in a dropdown
  @override
  bool filter(String query) {
    return lastName.toLowerCase().contains(query.toLowerCase());
  }
}
