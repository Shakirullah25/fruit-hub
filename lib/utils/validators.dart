String? validateName(String name) {
    if (name.isEmpty) {
      return "Name cannot be empty.";
    } else if (name.length > 25) {
      return "Name is too long.";
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(name)) {
      return "Please use only letters and spaces.";
    }
    return null; // valid
  }

String? validatePhoneNumber(String phone) {
  if (phone.isEmpty) {
    return "Phone number cannot be empty.";
  } else if (!RegExp(r"^\+?\d{10,15}$").hasMatch(phone)) {
    return "Please enter a valid phone number (10-15 digits).";
  }
  return null; // valid
}

String? validateAddress(String address) {
  if (address.isEmpty) {
    return "Address cannot be empty.";
  } else if (address.length < 10) {
    return "Address must be at least 10 characters long.";
  } else if (address.length > 200) {
    return "Address is too long.";
  }
  return null; // valid
}

// Card validation functions
String? validateCardHolderName(String name) {
  if (name.isEmpty) {
    return "Cardholder name cannot be empty.";
  } else if (name.length < 2) {
    return "Cardholder name must be at least 2 characters long.";
  } else if (name.length > 50) {
    return "Cardholder name is too long.";
  } else if (!RegExp(r"^[a-zA-Z\s\-\.\']+$").hasMatch(name)) {
    return "Please use only letters, spaces, hyphens, dots, and apostrophes.";
  } else if (RegExp(r"^\s|\s$").hasMatch(name)) {
    return "Cardholder name cannot start or end with spaces.";
  }
  return null; // valid
}

String? validateCardNumber(String cardNumber) {
  // Remove spaces and dashes
  String cleanedNumber = cardNumber.replaceAll(RegExp(r'[\s\-]'), '');
  
  if (cleanedNumber.isEmpty) {
    return "Card number cannot be empty.";
  } else if (!RegExp(r"^\d+$").hasMatch(cleanedNumber)) {
    return "Card number must contain only digits.";
  } else if (cleanedNumber.length < 13 || cleanedNumber.length > 19) {
    return "Card number must be between 13-19 digits.";
  }
  
  // Luhn algorithm validation
  if (!_isValidLuhn(cleanedNumber)) {
    return "Please enter a valid card number.";
  }
  
  return null; // valid
}

String? validateExpiryDate(String expiryDate) {
  if (expiryDate.isEmpty) {
    return "Expiry date cannot be empty.";
  }
  
  // Check format MM/YY or MM/YYYY
  if (!RegExp(r"^(0[1-9]|1[0-2])\/(\d{2}|\d{4})$").hasMatch(expiryDate)) {
    return "Please enter date in MM/YY or MM/YYYY format.";
  }
  
  List<String> parts = expiryDate.split('/');
  int month = int.parse(parts[0]);
  int year = int.parse(parts[1]);
  
  // Convert YY to YYYY
  if (year < 100) {
    year += 2000;
  }
  
  DateTime now = DateTime.now();
  DateTime cardExpiry = DateTime(year, month + 1, 0); // Last day of expiry month
  
  if (cardExpiry.isBefore(now)) {
    return "Card has expired.";
  }
  
  // Check if expiry is too far in the future (more than 10 years)
  DateTime maxExpiry = DateTime(now.year + 10, now.month);
  if (cardExpiry.isAfter(maxExpiry)) {
    return "Expiry date seems invalid.";
  }
  
  return null; // valid
}

String? validateCVV(String cvv) {
  if (cvv.isEmpty) {
    return "CVV cannot be empty.";
  } else if (!RegExp(r"^\d{3,4}$").hasMatch(cvv)) {
    return "CVV must be 3 or 4 digits.";
  }
  return null; // valid
}

// Luhn algorithm implementation for card number validation
bool _isValidLuhn(String cardNumber) {
  int sum = 0;
  bool alternate = false;
  
  for (int i = cardNumber.length - 1; i >= 0; i--) {
    int digit = int.parse(cardNumber[i]);
    
    if (alternate) {
      digit *= 2;
      if (digit > 9) {
        digit = (digit % 10) + 1;
      }
    }
    
    sum += digit;
    alternate = !alternate;
  }
  
  return sum % 10 == 0;
}

// Enhanced address validation
String? validateAddressStrict(String address) {
  if (address.isEmpty) {
    return "Address cannot be empty.";
  } else if (address.trim().length < 15) {
    return "Address must be at least 15 characters long.";
  } else if (address.length > 200) {
    return "Address is too long (max 200 characters).";
  } else if (!RegExp(r"^[a-zA-Z0-9\s\,\.\-\#\/]+$").hasMatch(address)) {
    return "Address contains invalid characters.";
  } else if (RegExp(r"^\s|\s$").hasMatch(address)) {
    return "Address cannot start or end with spaces.";
  } else if (!RegExp(r"\d").hasMatch(address)) {
    return "Address should include a house/building number.";
  }
  return null; // valid
}

// Enhanced phone validation
String? validatePhoneNumberStrict(String phone) {
  // Remove spaces, dashes, and parentheses
  String cleanedPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  
  if (phone.isEmpty) {
    return "Phone number cannot be empty.";
  } else if (cleanedPhone.length < 10) {
    return "Phone number must be at least 10 digits.";
  } else if (cleanedPhone.length > 15) {
    return "Phone number is too long (max 15 digits).";
  } else if (!RegExp(r"^\+?\d{10,15}$").hasMatch(cleanedPhone)) {
    return "Please enter a valid phone number.";
  } else if (RegExp(r"^(\d)\1{9,}$").hasMatch(cleanedPhone.replaceAll('+', ''))) {
    return "Phone number cannot be all the same digit.";
  }
  return null; // valid
}
