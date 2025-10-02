class AuthService {
  // Validation methods
  static String? validateFullName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Full name is required';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Main registration function
  static Future<AuthResult> registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Replace with your actual registration logic
      if (fullName.isNotEmpty && email.contains('@') && password.length >= 6) {
        return AuthResult.success('Registration successful!');
      } else {
        return AuthResult.error('Registration failed');
      }
    } catch (e) {
      return AuthResult.error('Registration failed: $e');
    }
  }

  // Social registration methods
  static Future<AuthResult> registerWithGoogle() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // Implement actual Google Sign In logic
      return AuthResult.success('Google registration successful!');
    } catch (e) {
      return AuthResult.error('Google registration failed: $e');
    }
  }

  static Future<AuthResult> registerWithApple() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // Implement actual Apple Sign In logic
      return AuthResult.success('Apple registration successful!');
    } catch (e) {
      return AuthResult.error('Apple registration failed: $e');
    }
  }
}

class AuthResult {
  final bool success;
  final String message;

  AuthResult.success(this.message) : success = true;
  AuthResult.error(this.message) : success = false;
}