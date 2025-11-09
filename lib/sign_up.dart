import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

enum UserRole { farmer, buyer }

class _SignUpPageState extends State<SignUpPage> {
  UserRole? selectedRole;
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a role')));
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Trigger sign-up logic with these fields and role
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signing up as ${selectedRole == UserRole.farmer ? 'Farmer' : 'Buyer'}')));
    }
  }

  Widget _roleCard(UserRole role, String title, String subtitle, IconData icon) {
    bool isSelected = selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = role;
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.green : Colors.grey.shade300,
              width: isSelected ? 2.5 : 1.2,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: Colors.green.shade200.withOpacity(0.4),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 54, color: Colors.green.shade700),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green.shade900),
              ),
              SizedBox(height: 6),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? toggleObscure,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.green.shade700,
          ),
          onPressed: toggleObscure,
        )
            : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // AgroConnect Logo & Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.eco, color: Colors.green.shade700, size: 40),
                    SizedBox(width: 10),
                    Text(
                      'AgroConnect',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Role selection title
                Text(
                  'Choose Your Role',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Select your role to continue using AgroConnect',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 20),

                // Role cards row
                Row(
                  children: [
                    _roleCard(
                      UserRole.farmer,
                      'Farmer',
                      'Sell your fresh produce directly',
                      Icons.agriculture_rounded,
                    ),
                    _roleCard(
                      UserRole.buyer,
                      'Buyer',
                      'Buy from local trusted farms',
                      Icons.storefront_rounded,
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Sign up form fields
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        label: 'First Name',
                        controller: firstNameController,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty)
                            return 'First name is required';
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      _buildTextField(
                        label: 'Last Name',
                        controller: lastNameController,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty)
                            return 'Last name is required';
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      _buildTextField(
                        label: 'Address',
                        controller: addressController,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty)
                            return 'Address is required';
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      _buildTextField(
                        label: 'Password',
                        controller: passwordController,
                        isPassword: true,
                        obscureText: _obscurePassword,
                        toggleObscure: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        validator: (val) {
                          if (val == null || val.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      _buildTextField(
                        label: 'Confirm Password',
                        controller: confirmPasswordController,
                        isPassword: true,
                        obscureText: _obscureConfirmPassword,
                        toggleObscure: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        validator: (val) {
                          if (val == null || val != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _onContinuePressed,
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}