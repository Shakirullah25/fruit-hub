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

