class ContactPerson {
  final int id;
  final String firstname;
  final String lastname;
  final String role;
  final String? phone;
  final String? email;
  final String image;

  ContactPerson(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.role,
      this.phone,
      this.email,
      required this.image});

  factory ContactPerson.fromJson(Map<String, dynamic> json) {
    return ContactPerson(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        role: json['role'],
        image: json['image'],
        phone: json['phone'],
        email: json['email']);
  }
}
