import 'package:flutter/material.dart';
import 'Authentication Logic/registration_controller.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final RegistrationController _controller = RegistrationController();

  void _registerUser() async {
    final result = await _controller.register();

    if (result.success) {
      _showSnackBar(result.message, true);
      _showSuccessDialog();
    } else {
      _showSnackBar(result.message, false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('Your account has been created successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close success dialog
                Navigator.of(context).pop(); // Go back to login page
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25),
                // logo
                Image.asset(
                  'lib/images/logo.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 25),

                // welcome message
                Text(
                  "Create Your Account",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),

                // full name text-field
                _buildTextField(
                  controller: _controller.fullNameController,
                  hintText: 'Full Name',
                  icon: Icons.person,
                  validator: _controller.validateFullName,
                ),

                const SizedBox(height: 15),

                // email text-field
                _buildTextField(
                  controller: _controller.emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: _controller.validateEmail,
                ),

                const SizedBox(height: 15),

                // password text-field
                _buildPasswordField(
                  controller: _controller.passwordController,
                  hintText: 'Password',
                  obscureText: _controller.obscurePassword,
                  onToggle: _controller.togglePasswordVisibility,
                  validator: _controller.validatePassword,
                ),

                const SizedBox(height: 15),

                // confirm password text-field
                _buildPasswordField(
                  controller: _controller.confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: _controller.obscureConfirmPassword,
                  onToggle: _controller.toggleConfirmPasswordVisibility,
                  validator: _controller.validateConfirmPassword,
                ),

                const SizedBox(height: 25),

                // register button
                _buildRegisterButton(),

                const SizedBox(height: 30),

                // or continue with
                _buildDivider(),

                const SizedBox(height: 30),

                // google or apple buttons
                _buildSocialButtons(),

                const SizedBox(height: 40),

                // login option
                _buildLoginOption(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    required String? Function() validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
              suffixIcon: Icon(icon, color: Colors.grey[600]),
            ),
            onChanged: (value) => setState(() {}),
          ),
          if (validator() != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0),
              child: Text(
                validator()!,
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
    required String? Function() validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey[600],
                ),
                onPressed: onToggle,
              ),
            ),
            onChanged: (value) => setState(() {}),
          ),
          if (validator() != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0),
              child: Text(
                validator()!,
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _controller.isLoading ? null : _registerUser,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _controller.isLoading
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : const Text(
            'Register',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Or continue with',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Google button
          GestureDetector(
            onTap: _controller.isLoading
                ? null
                : () async {
              final result = await _controller.registerWithGoogle();
              if (result.success) {
                _showSnackBar(result.message, true);
                _showSuccessDialog();
              } else {
                _showSnackBar(result.message, false);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: _controller.isLoading
                  ? const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : Image.asset(
                'lib/images/google.png',
                height: 40,
                width: 40,
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Apple button
          GestureDetector(
            onTap: _controller.isLoading
                ? null
                : () async {
              final result = await _controller.registerWithApple();
              if (result.success) {
                _showSnackBar(result.message, true);
                _showSuccessDialog();
              } else {
                _showSnackBar(result.message, false);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: _controller.isLoading
                  ? const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : Image.asset(
                'lib/images/apple.png',
                height: 40,
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),

        const SizedBox(width: 5),
        GestureDetector(
          onTap: _controller.isLoading ? null : () => Navigator.pop(context),
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.blue[700],
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}