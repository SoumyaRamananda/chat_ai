class Validators {
  Validators._();

  static String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Message cannot be empty";
    }
    if (value.trim().length > 2000) {
      return "Message is too long";
    }
    return null;
  }

  static String? validateDisplayName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    if (value.trim().length < 2) {
      return "Name is too short";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Invalid email address";
    }
    return null;
  }
}
