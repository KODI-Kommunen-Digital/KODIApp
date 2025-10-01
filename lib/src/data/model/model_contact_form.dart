class ContactForm {
  final String firstname;
  final String lastname;
  final String enquiery;
  final String? phone;
  final String? email;
  final String? key;


  ContactForm(
      {
        required this.firstname,
        required this.lastname,
        required this.enquiery,
        this.phone,
        this.email,
        this.key='contactUs',
       });

  factory ContactForm.fromJson(Map<String, dynamic> json) {
    return ContactForm(
        firstname: json['firstname'],
        lastname: json['lastname'],
        enquiery: json['enquiery'],
        phone: json['phoneNumber'],
        email: json['email'],
        key: json['key'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'enquiery': enquiery,
        'phoneNumber': phone,
        'email': email,
        'key': key,
      };
}
