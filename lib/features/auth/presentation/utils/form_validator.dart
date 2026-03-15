class FormValidator {
  static String? name(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }
    if (name.length < 2) {
      return 'Name must be more charecters';
    }
    return null;
  }

  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Enter valid email';
    }
    return null;
  }

  static String? pass(String? pass) {
    if (pass == null || pass.isEmpty) {
      return 'Password required';
    }
    if (pass.length < 6) {
      return 'Password must be 6 characters';
    }
    return null;
  }
}
