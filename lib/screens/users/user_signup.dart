// user_signup_page.dart
import 'package:flutter/material.dart';
import 'package:recyclick/Api%20Service/api_service.dart';
import 'package:recyclick/screens/users/user_navigation.dart';

class UserSignupPage extends StatefulWidget {
  @override
  _UserSignupPageState createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  // Controllers for text fields.
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Add a controller for city if needed.
  // final TextEditingController _cityController = TextEditingController();

  void _createAccount() async {
    // Validate that text fields are not empty.
    if (_aadharController.text.isEmpty ||
        _fullNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required.')),
      );
      return;
    }

    // Validate Aadhar number.
    final int aadhar = int.tryParse(_aadharController.text) ?? 0;
    if (aadhar == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid Aadhar Number.')),
      );
      return;
    }

    final String name = _fullNameController.text;
    final String phoneNumber = _phoneController.text;
    final String password = _passwordController.text;
    final String city = 'Jaipur'; // Replace or capture from input.
    final String role = 'customer';

    // Initialize the API service.
    final apiService = ApiService();

    // Call the API to create an account.
    final success = await apiService.createAccount(
      role: role,
      aadhar: aadhar,
      name: name,
      phoneNumber: phoneNumber,
      password: password,
      city: city,
    );

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserHomePage()),
      );
    } else {
      // Show error message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create account. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar as per requirements.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image.
          Image.asset('assets/main_bg.png', fit: BoxFit.cover),
          // Form overlay with scrolling support.
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Heading: "Create. an. Account." (Account in green).
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Create. an. ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Account.',
                          style: TextStyle(color: Color(0xFF1BA133)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Centered Avatar Image.
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                  ),
                  SizedBox(height: 30),
                  // White container with 60% opacity for text fields and button.
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        // Aadhar Number TextField.
                        TextField(
                          controller: _aadharController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Aadhar Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Full Name TextField.
                        TextField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Phone Number TextField.
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15),
                        // Password TextField.
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Create Account Button.
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _createAccount,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1BA133),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
