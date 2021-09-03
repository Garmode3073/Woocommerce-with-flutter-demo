class CustomerModel {
  String email;
  String firstname;
  String lastname;
  String password;

  CustomerModel({
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map.addAll({
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'password': password,
      'username': email,
    });

    return map;
  }
}
