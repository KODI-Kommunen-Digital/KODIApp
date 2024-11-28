enum ValidateType {
  normal,
  email,
  cemail,
  number,
  phone,
  tag,
  cpassword,
  website,
  card,
  trolleyMakerPassword,
  zipCode
}

class UtilValidator {
  static const String errorEmpty = "value_not_empty";
  static const String errorRange = "value_not_valid_range";
  static const String errorEmail = "value_not_valid_email";
  static const String errorNumber = "value_not_number";
  static const String errorPhone = "value_not_phone";
  static const String errorPassword = "value_not_valid_password";
  static const String errorId = "value_not_valid_id";
  static const String errorCpassword = "value_not_equal_password";
  static const String errorWebsite = "value_not_website";
  static const String valueNotMatch = "value_not_match";
  static const String valueNotIsTag = "value_not_is_tag";
  static const String invalidCardId = "invalid_card_id";
  static const String emailNotMatch = "email_not_mach";
  static const String invalidZipCode = "invalid_zip_code";

  static String? validate(String data,
      {ValidateType? type = ValidateType.normal,
      int? min,
      int? max,
      bool allowEmpty = false,
      String? match,
      String? password,
      String? email}) {
    ///Empty
    if (!allowEmpty && data.isEmpty) {
      return errorEmpty;
    }

    ///Match
    if (match != null && match != data) {
      return valueNotMatch;
    }

    if (data.isEmpty) return null;

    switch (type) {
      ///Email pattern
      case ValidateType.email:
        final emailRegex = RegExp(
          //r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        );
        if (!emailRegex.hasMatch(data)) {
          return errorEmail;
        }
        break;

      ///Phone pattern
      case ValidateType.number:
        final phoneRegex = RegExp(r'^[0-9]*$');
        if (!phoneRegex.hasMatch(data)) {
          return errorNumber;
        }
        break;

      ///Phone pattern
      case ValidateType.phone:
        const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
        final phoneRegex = RegExp(pattern);
        if (!phoneRegex.hasMatch(data)) {
          return errorPhone;
        }
        break;

      ///Tag pattern
      case ValidateType.tag:
        final tagRegex = RegExp(r'^([^0-9|\,\s]*)$');
        if (!tagRegex.hasMatch(data)) {
          return valueNotIsTag;
        }
        break;

      ///Is cpassword equal to password
      case ValidateType.cpassword:
        if (password != data) {
          return errorCpassword;
        }
        break;

      case ValidateType.website:
        final websiteRegex = RegExp(
            r"^(https?|ftp):\/\/(?:www\.)?([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})(?:\/[^\s]*)?$");
        if (!websiteRegex.hasMatch(data)) {
          return errorWebsite;
        }
        break;

      case ValidateType.card:
        if (!validateCardID(data)) {
          return invalidCardId;
        }
        break;
      case ValidateType.cemail:
        if (data != email) {
          return emailNotMatch;
        }
        break;
      case ValidateType.trolleyMakerPassword:
        if (!_validateTrolleyMakerPassword(data)) {
          return errorPassword;
        }
        break;
      case ValidateType.zipCode:
        if (!_validZipCode(data)) {
          return invalidZipCode;
        }
        break;
      default:
    }
    return null;
  }

  static bool _validateTrolleyMakerPassword(String password) {
    // Check if the password has at least 8 characters
    if (password.length < 8) {
      return false;
    }

    // Check if the password contains at least 1 capital letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return false;
    }

    // Check if the password contains at least 1 digit
    if (!RegExp(r'\d').hasMatch(password)) {
      return false;
    }

    // Check if the password contains at least 1 special character from the specified set
    if (!RegExp(r'[!$%()*,-.?@^_~]').hasMatch(password)) {
      return false;
    }
    // Check if the password contains spaces
    if (password.contains(' ')) {
      return false;
    }

    // All checks passed
    return true;
  }

  static bool _validZipCode(String value) {
    final RegExp regex = RegExp(r'^\d{4,5}$');
    return regex.hasMatch(value);
  }

  static bool validateCardID(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return false;
    }
    if (value.length != 15) {
      return false;
    }
    if (!value.startsWith("1761")) {
      return false;
    }
    return true; // Valid
  }

  ///Singleton factory
  static final UtilValidator _instance = UtilValidator._internal();

  factory UtilValidator() {
    return _instance;
  }

  UtilValidator._internal();
}
