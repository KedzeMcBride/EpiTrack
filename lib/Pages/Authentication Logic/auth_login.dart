class AuthService {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Login API call
  static Future<bool> login(String username, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Replace with your actual login logic
    if (username.isNotEmpty && password.length >= 6) {
      return true; // Login successful
    }
    return false; // Login failed
  }

  // Social login methods
  static Future<bool> googleSignIn() async {
    await Future.delayed(const Duration(seconds: 2));
    // Implement actual Google Sign In logic
    return true;
  }

  static Future<bool> appleSignIn() async {
    await Future.delayed(const Duration(seconds: 2));
    // Implement actual Apple Sign In logic
    return true;
  }

  // Password reset
  static Future<bool> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 2));
    // Implement actual password reset logic
    return true;
  }
}