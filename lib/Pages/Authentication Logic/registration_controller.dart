import 'package:flutter/material.dart';
import 'package:epitrack/Pages/Authentication Logic/auth_registration.dart';

class RegistrationController with ChangeNotifier {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Getters
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get isLoading => _isLoading;

  // Password visibility toggles
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  // Validation methods
  String? validateFullName() {
    return AuthService.validateFullName(fullNameController.text);
  }

  String? validateEmail() {
    return AuthService.validateEmail(emailController.text);
  }

  String? validatePassword() {
    return AuthService.validatePassword(passwordController.text);
  }

  String? validateConfirmPassword() {
    return AuthService.validateConfirmPassword(
      passwordController.text,
      confirmPasswordController.text,
    );
  }

  // Check if form is valid
  bool get isFormValid {
    return validateFullName() == null &&
        validateEmail() == null &&
        validatePassword() == null &&
        validateConfirmPassword() == null;
  }

  // Main registration function
  Future<AuthResult> register() async {
    if (!isFormValid) {
      return AuthResult(
        success: false,
        errorMessage: 'Please fix validation errors',
      );
    }

    _isLoading = true;
    notifyListeners();

    final result = await AuthService.registerUser(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    _isLoading = false;
    notifyListeners();

    return result;
  }

  // Social registration
  Future<AuthResult> registerWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    final result = await AuthService.registerWithGoogle();

    _isLoading = false;
    notifyListeners();

    return result;
  }

  Future<AuthResult> registerWithApple() async {
    _isLoading = true;
    notifyListeners();

    final result = await AuthService.registerWithApple();

    _isLoading = false;
    notifyListeners();

    return result;
  }

  // Clear form
  void clearForm() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}