class CustomerModel {
  String? email;
  String? firstname;
  String? lastname;
  String? password;

  CustomerModel({
    this.email,
    this.firstname,
    this.lastname,
    this.password,
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
