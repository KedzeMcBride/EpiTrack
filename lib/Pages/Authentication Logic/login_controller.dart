import 'package:epitrack/Pages/Authentication Logic/auth_login.dart';

class LoginController {
  // Validation methods using AuthService
  String? validateUsername(String? value) {
    return AuthService.validateUsername(value);
  }

  String? validatePassword(String? value) {
    return AuthService.validatePassword(value);
  }

  // Login method
  Future<LoginResult> login(String username, String password) async {
    try {
      final success = await AuthService.login(username, password);
      if (success) {
        return LoginResult.success('Login successful');
      } else {
        return LoginResult.error('Invalid credentials');
      }
    } catch (e) {
      return LoginResult.error('Login failed: $e');
    }
  }

  // Social login methods
  Future<LoginResult> googleLogin() async {
    try {
      final success = await AuthService.googleSignIn();
      if (success) {
        return LoginResult.success('Google login successful');
      } else {
        return LoginResult.error('Google login failed');
      }
    } catch (e) {
      return LoginResult.error('Google login failed: $e');
    }
  }

  Future<LoginResult> appleLogin() async {
    try {
      final success = await AuthService.appleSignIn();
      if (success) {
        return LoginResult.success('Apple login successful');
      } else {
        return LoginResult.error('Apple login failed');
      }
    } catch (e) {
      return LoginResult.error('Apple login failed: $e');
    }
  }

  // Password reset
  Future<bool> forgotPassword(String email) async {
    try {
      return await AuthService.resetPassword(email);
    } catch (e) {
      return false;
    }
  }
}

// Result class for handling login outcomes
class LoginResult {
  final bool isSuccess;
  final String message;

  LoginResult.success(this.message) : isSuccess = true;
  LoginResult.error(this.message) : isSuccess = false;
}