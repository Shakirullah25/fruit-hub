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


