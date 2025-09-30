class AuthService {
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
    // Validate all fields
    final fullNameError = validateFullName(fullName);
    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    if (fullNameError != null || emailError != null || passwordError != null) {
      return AuthResult(
        success: false,
        errorMessage: 'Please fix validation errors',
        validationErrors: {
          'fullName': fullNameError,
          'email': emailError,
          'password': passwordError,
        },
      );
    }

    try {
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with your actual registration logic
      // Example with Firebase Auth:
      /*
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save additional user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      */

      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  // Social registration methods
  static Future<AuthResult> registerWithGoogle() async {
    try {
      // TODO: Implement Google sign-in
      await Future.delayed(const Duration(seconds: 2));
      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Google registration failed: ${e.toString()}',
      );
    }
  }

  static Future<AuthResult> registerWithApple() async {
    try {
      // TODO: Implement Apple sign-in
      await Future.delayed(const Duration(seconds: 2));
      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Apple registration failed: ${e.toString()}',
      );
    }
  }
}

class AuthResult {
  final bool success;
  final String? errorMessage;
  final Map<String, String?>? validationErrors;

  AuthResult({
    required this.success,
    this.errorMessage,
    this.validationErrors,
  });
}