class TrolleyMakerRegisterRequest {
  final String cardID;
  final String email;
  final String emailRepeated;
  final String password;
  final String passwordRepeated;
  final String gender;
  final String firstName;
  final String lastName;
  final String street;
  final String zip;
  final String city;
  final String country;
  final String phone;
  final String birthdate;
  final bool conditionsConsent;
  final bool marketingAdsConsent;
  final bool newsletterConsent;

  TrolleyMakerRegisterRequest({
    required this.cardID,
    required this.email,
    required this.emailRepeated,
    required this.password,
    required this.passwordRepeated,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.zip,
    required this.city,
    required this.country,
    required this.phone,
    required this.birthdate,
    required this.conditionsConsent,
    required this.marketingAdsConsent,
    required this.newsletterConsent,
  });

  // Factory method to create an instance from a JSON map
  factory TrolleyMakerRegisterRequest.fromJson(Map<String, dynamic> json) {
    return TrolleyMakerRegisterRequest(
      cardID: json['cardID'],
      email: json['email'],
      emailRepeated: json['emailRepeated'],
      password: json['password'],
      passwordRepeated: json['passwordRepeated'],
      gender: json['gender'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      street: json['street'],
      zip: json['zip'],
      city: json['city'],
      country: json['country'],
      phone: json['phone'],
      birthdate: json['birthdate'],
      conditionsConsent: json['conditionsConsent'],
      marketingAdsConsent: json['marketingAdsConsent'],
      newsletterConsent: json['newsletterConsent'],
    );
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'cardID': cardID,
      'email': email,
      'emailRepeated': emailRepeated,
      'password': password,
      'passwordRepeated': passwordRepeated,
      'gender': gender,
      'firstName': firstName,
      'lastName': lastName,
      'street': street,
      'zip': zip,
      'city': city,
      'country': country,
      'phone': phone,
      'birthdate': birthdate,
      'conditionsConsent': conditionsConsent,
      'marketingAdsConsent': marketingAdsConsent,
      'newsletterConsent': newsletterConsent,
    };
  }
}