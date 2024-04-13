class SignUpRequest {
  String email;
  String password;
  String name;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name, // Include the new parameter
    };
  }
}
