// login_page.dart
import 'package:flutter/material.dart';
import 'package:recyclick/Api%20Service/api_service.dart';
import 'package:recyclick/screens/account_type.dart';
import 'package:recyclick/screens/users/user_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for text fields.
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dropdown variables.
  final List<String> _roles = ['customer', 'vendor', 'collector_company'];
  String _selectedRole = 'customer';

  // Function for "Create Account" tap action.
  void _onCreateAccountTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountType()),
    );
  }

  void _login() async {
    // Validate that text fields are not empty.
    if (_aadharController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Aadhar and Password cannot be empty.')),
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

    final String password = _passwordController.text;
    final String role = _selectedRole;

    // Initialize the API service.
    final apiService = ApiService();

    // Call the API to login.
    final success = await apiService.login(
      role: role,
      aadhar: aadhar,
      password: password,
    );

    if (success) {
      // Store the Aadhar number in local storage.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('aadhar', aadhar);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserHomePage()),
      );
    } else {
      // Show error message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please check your credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove any default app bar by leaving it null.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image.
          Image.asset('assets/main_bg.png', fit: BoxFit.cover),
          // Overlay for the login form.
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading with Montserrat font, size 40, aligned to left.
                  Text(
                    'Click. Track. Recycle',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 40,
                      fontWeight: FontWeight.w900, // Extra bold weight.
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10),
                  // Subtext remains centered.
                  Center(
                    child: Text(
                      'Give old gadgets a second life instead of tossing them',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  // Container with white background and 60% opacity for text fields and buttons.
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          // Dropdown for Role Selection.
                          DropdownButtonFormField<String>(
                            value: _selectedRole,
                            decoration: InputDecoration(
                              labelText: 'Select Role',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                            items: _roles.map((String role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRole = newValue!;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          // Aadhar Number TextField.
                          TextField(
                            controller: _aadharController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Aadhar Number',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Password TextField.
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                          ),
                          SizedBox(height: 30),
                          // Login Button.
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1BA133),
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // "Not register yet? Create Account" text.
                          GestureDetector(
                            onTap: () => _onCreateAccountTap(context),
                            child: RichText(
                              text: TextSpan(
                                text: 'Not register yet? ',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Create Account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
